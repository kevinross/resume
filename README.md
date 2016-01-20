# Resume Tool

To use, copy `config.mk.in` to `config.mk` and edit the variables for the target web server and PDF filenames.

Next, edit `resume.json` to your liking and run `make` to build the formats. Run `make copytoserver` to copy the HTML and PDF to the docroot specified in `config.mk`.

# Templates

Original templates are sourced from the `json_resume` gem with some modification for included data. Additionally, each section is extracted into it's own file so they can be reordered easily (the `sections` file contains the order).

The license for the originals is MIT and can be found in `templates/LICENSE`.
