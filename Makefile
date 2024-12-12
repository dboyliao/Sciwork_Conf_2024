UPDATE_MESSAGE?=update slides

slides:
	jupyter nbconvert \
	--to slides \
	--SlidesExporter.reveal_theme=serif \
	--output-dir slides \
	NumPy-dark.ipynb

gh-page-worktree:
	@if [ ! -e worktree/gh-pages ]; then \
		mkdir -p worktree; \
		git worktree add \
		--checkout worktree/gh-pages gh-pages; \
	fi;

update-slides: gh-page-worktree slides
	cp NumPy-dark.slides.html worktree/gh-pages/index.html
	cp images/* worktree/gh-pages/images/
	@cd worktree/gh-pages; \
	git add -A; \
	git commit -m '$(UPDATE_MESSAGE)'; \
	git push origin gh-pages;