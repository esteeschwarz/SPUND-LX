// Open all navbar links (.navbar a) in a new tab:
document.addEventListener("DOMContentLoaded", () => {
  const navLinks = document.querySelectorAll(".navbar a");
  navLinks.forEach(a => {
    // Skip dropdown toggles (no href)
    if (a.getAttribute("href")) {
      a.setAttribute("target", "_blank");
      a.setAttribute("rel", "noopener noreferrer");
    }
  });
});
