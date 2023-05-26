namespace BulkIssue.Controllers;

using BulkIssue.Models;
using EFCore.BulkExtensions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("api/[controller]")]
[ApiController]
public class TestsController : ControllerBase
{
    private readonly BulkIssueContext _context;

    public TestsController(BulkIssueContext context)
    {
        _context = context;
    }

    [HttpGet("reproduce-issue")]
    public async Task<ActionResult> ReproduceIssue()
    {
        var id = Guid.NewGuid();
        const string value = "Test";
        var item = new Test
        {
            Id = id,
            Value = value,
        };
        _ = _context.Test.Add(item);

        _ = await _context.SaveChangesAsync();

        //Console.WriteLine(BitConverter.ToString(item.RowVersion));

        var bulkConfig = new BulkConfig
        {
            PropertiesToExclude = new List<string> { "RowVersion" },
            PropertiesToExcludeOnCompare = new List<string> { "RowVersion" },
            PropertiesToExcludeOnUpdate = new List<string> { "RowVersion" },
            CalculateStats = true,
        };

        var updatedItems = new List<Test>
        {
            new Test
            {
                Id = id,
                Value = "Tested",
                RowVersion = new byte[] {1,2,3},
            },
        };

        await _context.BulkInsertOrUpdateAsync(updatedItems, bulkConfig);

        var affected = (bulkConfig.StatsInfo?.StatsNumberInserted ?? 0) +
                       (bulkConfig.StatsInfo?.StatsNumberUpdated ?? 0) +
                       (bulkConfig.StatsInfo?.StatsNumberDeleted ?? 0);

        return Ok(affected);
    }

    // GET: api/Tests
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Test>>> GetTest()
        => _context.Test == null ? NotFound() : await _context.Test.ToListAsync();

    // GET: api/Tests/5
    [HttpGet("{id:guid}")]
    public async Task<ActionResult<Test>> GetTest(Guid id)
    {
        if (_context.Test == null)
        {
            return NotFound();
        }

        var test = await _context.Test.FindAsync(id);

        return test == null ? NotFound() : test;
    }

    // PUT: api/Tests/5
    // To protect from over-posting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPut("{id:guid}")]
    public async Task<IActionResult> PutTest(Guid id, Test test)
    {
        if (id != test.Id)
        {
            return BadRequest();
        }

        _context.Entry(test).State = EntityState.Modified;

        try
        {
            _ = await _context.SaveChangesAsync();
        }
        catch (DbUpdateConcurrencyException)
        {
            if (!TestExists(id))
            {
                return NotFound();
            }
            else
            {
                throw;
            }
        }

        return NoContent();
    }

    // POST: api/Tests
    // To protect from over-posting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
    [HttpPost]
    public async Task<ActionResult<Test>> PostTest(Test test)
    {
        if (_context.Test == null)
        {
            return Problem("Entity set 'BulkIssueContext.Test'  is null.");
        }

        _ = _context.Test.Add(test);
        try
        {
            _ = await _context.SaveChangesAsync();
        }
        catch (DbUpdateException)
        {
            if (TestExists(test.Id))
            {
                return Conflict();
            }
            else
            {
                throw;
            }
        }

        return CreatedAtAction("GetTest", new { id = test.Id }, test);
    }

    // DELETE: api/Tests/5
    [HttpDelete("{id:guid}")]
    public async Task<IActionResult> DeleteTest(Guid id)
    {
        if (_context.Test == null)
        {
            return NotFound();
        }

        var test = await _context.Test.FindAsync(id);
        if (test == null)
        {
            return NotFound();
        }

        _ = _context.Test.Remove(test);
        _ = await _context.SaveChangesAsync();

        return NoContent();
    }

    private bool TestExists(Guid id)
    {
        return (_context.Test?.Any(e => e.Id == id)).GetValueOrDefault();
    }
}