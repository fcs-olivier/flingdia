document.addEventListener("DOMContentLoaded", () => {
  const toc = document.querySelector(
    ".md-sidebar--secondary .md-nav__list[data-md-component='toc']",
  );
  const headings = Array.from(
    document.querySelectorAll(".asp-doc h3[id]"),
  ).filter((heading) => heading.textContent.includes("("));

  if (!toc || headings.length === 0) {
    return;
  }

  for (const link of toc.querySelectorAll('a[href$=".lp"]')) {
    link.closest("li")?.remove();
  }

  for (const heading of headings) {
    const href = `#${heading.id}`;

    if (toc.querySelector(`a[href="${href}"]`)) {
      continue;
    }

    const item = document.createElement("li");
    const link = document.createElement("a");

    item.className = "md-nav__item";
    link.className = "md-nav__link";
    link.href = href;
    link.textContent = heading.textContent
      .replace("¶", "")
      .trim()
      .replace(/\([^)]*\)$/, "");

    item.append(link);
    toc.append(item);
  }
});
