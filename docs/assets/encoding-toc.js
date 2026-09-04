document.addEventListener("DOMContentLoaded", () => {
  const toc = document.querySelector(
    ".md-sidebar--secondary .md-nav__list[data-md-component='toc']",
  );
  if (!toc) {
    return;
  }

  // Clindocs `%#` section titles become h3. Include all of them, not only
  // predicate signatures such as `left(P1,P2)`. Skip the encoding filename.
  const headings = Array.from(
    document.querySelectorAll(".asp-doc h3[id]"),
  ).filter((heading) => !heading.id.endsWith(".lp"));

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
