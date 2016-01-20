import json, sys

if sys.argv[1] == 'json':
	resume = json.loads(open('resume.json').read())
	references = json.loads(open('references.json').read())

	resume['references'] = references

	with open('resume_references.json', 'w') as f:
		f.write(json.dumps(resume))
elif sys.argv[1] == 'tex':
	tpl = open('templates/tex/references').read()
	header = open('templates/tex/header').read()

	with open('references.mustache', 'w') as f:
		f.write(tpl.replace('header', header))
