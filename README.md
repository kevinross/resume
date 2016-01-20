# Resume Tool

To use, copy `config.mk.in` to `config.mk` and edit the variables for the target web server and PDF filenames.

## Resume

Edit `resume.json` to your liking and run `make` to build the formats.

## References

Copy `references.json.sample` to `references.json` and edit to your liking. References page is a simple list of names, relations, and contact information

Note: the reference list and every part of it is not automatically copied to the web server as it will contain personal information other than your own that should not be published without permission.

# Putting your resume online

Run `make copytoserver` to copy the HTML and PDF to the docroot specified in `config.mk`.

# Templates

Original templates are sourced from the `json_resume` gem with some modification for included data. Additionally, each section is extracted into it's own file so they can be reordered easily (the `sections` file contains the order).

The license for the originals is MIT and can be found in `templates/LICENSE`.
