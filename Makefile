TPL_FILES=$(wildcard templates/*/*)

all: Kevin_Ross_Resume.pdf Kevin_Ross_References.pdf index.zip

clean:
	rm Kevin_Ross_Resume.pdf Kevin_Ross_References.pdf
	rm resume/page.html
	rm index.zip

default_%.mustache: sections $(TPL_FILES)
	python make_templates.py $@

Kevin_Ross_Resume.pdf: kevin_ross.json default_tex.mustache
	GEM_HOME=/usr/local/gems json_resume convert --template=default_tex.mustache --out=tex_pdf kevin_ross.json
	mv resume.pdf Kevin_Ross_Resume.pdf

Kevin_Ross_References.pdf: references.txt
	pdflatex references.txt
	mv references.pdf Kevin_Ross_References.pdf
	rm references.out references.log references.aux

resume/page.html: kevin_ross.json default_html.mustache
	GEM_HOME=/usr/local/gems json_resume convert --template=default_html.mustache --out=html kevin_ross.json
	cat resume/page.html | sed -e 's/Curricular Awards/Curricular/' -e 's/got to work on/used/g' >page.html
	cat resume/index.html | sed 's/http:\/\/code/\/\/code/' >index.html
	cat resume/base-page.html | sed 's/http:\/\/code/\/\/code/' >base-page.html
	mv page.html resume/page.html
	mv index.html resume/index.html
	mv base-page.html resume/base-page.html

index.zip: resume/page.html Kevin_Ross_Resume.pdf
	cd resume; \
	zip -r ../index.zip * ../Kevin_Ross_Resume.pdf

copytoserver: index.zip
	scp index.zip root@pellet:/var/www/work.kevinross.name/
	ssh root@pellet "pushd /var/www/work.kevinross.name; unzip -o index.zip; chmod -R a+r ."

.PHONY: all
