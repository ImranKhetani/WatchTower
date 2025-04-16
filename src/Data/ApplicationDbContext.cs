using Microsoft.EntityFrameworkCore;
using Watchtower.Models;

namespace Watchtower.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options) { }

        public DbSet<Product> Products { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder); // Call the base method
            
            modelBuilder.Entity<Product>().HasData(
                new Product { Id = 1, Name = "Laptop", ImageUrl = "/images/laptop.jpg", Price = 1000 },
                new Product { Id = 2, Name = "Smartphone", ImageUrl = "/images/smartphone.jpg", Price = 800 },
                new Product { Id = 3, Name = "Headphones", ImageUrl = "/images/headphones.jpg", Price = 150 },
                new Product { Id = 4, Name = "Tablet", ImageUrl = "/images/tablet.jpg", Price = 500 },
                new Product { Id = 5, Name = "Smartwatch", ImageUrl = "/images/smartwatch.jpg", Price = 250 },
                new Product { Id = 6, Name = "Camera", ImageUrl = "/images/camera.jpg", Price = 700 }
            );
        }
    }
}
