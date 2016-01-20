import sys
sections = open('sections').read().splitlines()

def get_template(fm):
	d = {'header': open('templates/%s/header' % fm).read()}
	for i, v in enumerate(sections):
		d['section%d' % (i+1)] = open('templates/%s/%s' % (fm, v)).read()
	if len(sections) < 6:
		for i in range(len(sections) + 1, 7):
			d['section%d' % i] = ''
	base = open('templates/%s/base' % fm).read()
	for k, v in d.iteritems():
		base = base.replace(k, v)
	return base

t = sys.argv[1].replace('default_','').replace('.mustache','')
with open(sys.argv[1], 'w') as f:
	f.write(get_template(t))
