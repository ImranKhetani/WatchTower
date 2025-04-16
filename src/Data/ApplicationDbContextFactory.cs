using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Watchtower.Data;

namespace Watchtower
{
    public class ApplicationDbContextFactory : IDesignTimeDbContextFactory<ApplicationDbContext>
    {
        public ApplicationDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<ApplicationDbContext>();

            // Specify the connection string explicitly for design-time commands
            optionsBuilder.UseSqlite("Data Source=Watchtower.db");

            return new ApplicationDbContext(optionsBuilder.Options);
        }
    }
}
