include config.mk

TPL_FILES=$(wildcard templates/*/*)

all: index.zip references.pdf

clean:
	rm resume.pdf references.pdf
	rm resume/page.html
	rm index.zip

templates/html/base: templates/html/base.in
	sed "s/PDFPREFIX/$(PDF_PREFIX)/" templates/html/base.in >templates/html/base

default_%.mustache: sections $(TPL_FILES) templates/html/base
	python make_templates.py $@

resume.pdf: resume.json default_tex.mustache
	GEM_HOME=/usr/local/gems json_resume convert --template=default_tex.mustache --out=tex_pdf resume.json

references.mustache: templates/tex/references templates/tex/header
	python make_references.py tex

resume_references.json: resume.json references.json
	python make_references.py json
	
references.pdf: references.mustache resume_references.json
	mv resume.pdf actual_resume.pdf
	GEM_HOME=/usr/local/gems json_resume convert --template=references.mustache --out=tex_pdf resume_references.json
	mv resume.pdf references.pdf
	mv actual_resume.pdf resume.pdf

resume/page.html: resume.json default_html.mustache
	GEM_HOME=/usr/local/gems json_resume convert --template=default_html.mustache --out=html resume.json
	sed -i '' -e 's/Curricular Awards/Curricular/' -e 's/got to work on/used/g' resume/page.html
	sed -i '' 's/http:\/\/code/\/\/code/' resume/index.html
	sed -i '' 's/http:\/\/code/\/\/code/' resume/core-page.html

index.zip: resume/page.html resume.pdf
	cp resume.pdf "$(PDF_PREFIX)_Resume.pdf"
	cd resume; \
	zip -r ../index.zip * ../$(PDF_PREFIX)_Resume.pdf
	rm $(PDF_PREFIX)_Resume.pdf

copytoserver: index.zip
	scp index.zip $(USER)@$(SERVER):$(SRVPATH)
	ssh $(USER)@$(SERVER) "pushd $(SRVPATH); unzip -o index.zip; chmod -R a+r ."

.PHONY: all
