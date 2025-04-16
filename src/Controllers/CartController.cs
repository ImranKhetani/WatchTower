using Microsoft.AspNetCore.Mvc;
using Watchtower.Data;
using Watchtower.Models;

public class CartController : Controller
{
    private readonly ApplicationDbContext _context;

    public CartController(ApplicationDbContext context)
    {
        _context = context;
    }

    public IActionResult AddToCart(int productId)
    {
        var cart = HttpContext.Session.GetString("Cart") ?? "";
        cart += productId + ",";
        HttpContext.Session.SetString("Cart", cart);
        return RedirectToAction("Index", "Products");
    }

    public IActionResult ViewCart()
    {
        var cart = HttpContext.Session.GetString("Cart") ?? "";
        var productIds = cart.Split(',', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList();
        var productsInCart = _context.Products.Where(p => productIds.Contains(p.Id)).ToList();

        return View(productsInCart);
    }

    public IActionResult RemoveFromCart(int productId)
    {
        var cart = HttpContext.Session.GetString("Cart") ?? "";
        var productIds = cart.Split(',', StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToList();
        productIds.Remove(productId);

        HttpContext.Session.SetString("Cart", string.Join(",", productIds));
        return RedirectToAction("ViewCart");
    }
}
