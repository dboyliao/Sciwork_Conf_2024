UPDATE_MESSAGE?=update slides
TARGET?=ortools-cheatsheet

_slides:
	jupyter nbconvert \
	--to slides \
	--SlidesExporter.reveal_theme=serif \
	--output-dir slides \
	notebook/$(TARGET).ipynb

_gh-page-worktree:
	@if [ ! -e worktree/gh-pages ]; then \
		mkdir -p worktree; \
		git worktree add \
		--checkout worktree/gh-pages gh-pages; \
	fi;

update-slides: _gh-page-worktree _slides
	mkdir -p worktree/gh-pages/$(TARGET)
	cp slides/$(TARGET).slides.html worktree/gh-pages/$(TARGET)/index.html

commit-slides:
	@cd worktree/gh-pages; \
	git add -A; \
	git commit -m '$(UPDATE_MESSAGE)'; \
	git push origin gh-pages;

.PHONY: slides