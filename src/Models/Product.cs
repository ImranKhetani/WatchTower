namespace Watchtower.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string? Name { get; set; } // Nullable
        public string? ImageUrl { get; set; } // Nullable
        public decimal Price { get; set; }
    }
}
