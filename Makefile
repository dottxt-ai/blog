.PHONY: all

all: publish

publish: publish.el
		@echo "Building dottxt Engineering with emacs"
		emacs --batch -q --load publish.el --funcall my/publish-all

clean:
		echo "Cleaning up.."
		rm -rvf *.elc
		rm -rvf _public
		rm -rvf ~/.org-timestamps/*
