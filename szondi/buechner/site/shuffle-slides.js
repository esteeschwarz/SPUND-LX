document.addEventListener("DOMContentLoaded", () => {
  const total = Reveal.getTotalSlides();

  Reveal.configure({
    keyboard: {
      32: "next",     // space
      39: "next",     // → arrow
    }
  });

  Reveal.next = function() {
    const target = Math.floor(Math.random() * total);
    Reveal.slide(target);
  };
});
