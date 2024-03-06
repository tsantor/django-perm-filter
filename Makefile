# -----------------------------------------------------------------------------
# Generate help output when running just `make`
# -----------------------------------------------------------------------------
.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help:
	@python3 -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

# -----------------------------------------------------------------------------

python_version=3.9.11
venv=djangopermfilter_env

# -----------------------------------------------------------------------------
# Development
# -----------------------------------------------------------------------------

env:  ## Create virtual environment
	pyenv virtualenv ${python_version} ${venv} && pyenv local ${venv}

reqs:  ## Install requirements
	python3 -m pip install -U pip && \
		python -m pip install -r requirements_dev.txt && \
		python -m pip install -r requirements_test.txt

migrations:  ## Create migrations
	python3 manage.py makemigrations

migrate:  ## Apply migrations
	python3 manage.py migrate

superuser:  ## Create superuser
	python3 manage.py createsuperuser

serve:  ## Run server
	python3 manage.py runserver 127.0.0.1:8000

manage:	## run django manage.py (eg - make manage cmd="shell")
	python3 manage.py ${cmd}

show_urls:  ## show urls
	python3 manage.py show_urls

shell:  ## run shell
	python3 manage.py shell_plus

flush:  ## Flush database
	python3 manage.py flush

pip_list:  ## run pip list
	python3 -m pip list

tree:  ## Show directory tree
	tree -I 'build|dist|htmlcov|node_modules|migrations|contrib|__pycache__|*.egg-info'

# -----------------------------------------------------------------------------
# Cleanup
# -----------------------------------------------------------------------------

clean-build: ## remove build artifacts
	rm -fr build/ dist/ .eggs/
	find . -name '*.egg-info' -o -name '*.egg' -exec rm -fr {} +

clean-pyc: ## remove Python file artifacts
	find . \( -name '*.pyc' -o -name '*.pyo' -o -name '*~' -o -name '__pycache__' \) -exec rm -fr {} +

clean: clean-build clean-pyc ## remove all build, test, coverage and Python artifacts

# -----------------------------------------------------------------------------
# Testing
# -----------------------------------------------------------------------------

pytest:  ## Run tests
	pytest -v -x

pytest_verbose:  ## Run tests
	pytest -vs

coverage:  ## Run tests with coverage
	coverage run -m pytest && coverage html

coverage_verbose:  ## Run tests with coverage
	coverage run -m pytest -vs && coverage html

coverage_skip:  ## Run tests with coverage
	coverage run -m pytest -vs && coverage html --skip-covered

open_coverage:  ## open coverage report
	open htmlcov/index.html

# -----------------------------------------------------------------------------
# Deploy
# -----------------------------------------------------------------------------

dist: clean ## builds source and wheel package
	python -m build --wheel

release_test: ## upload package to pypi test
	twine upload dist/* -r pypitest

release: dist ## package and upload a release
	twine upload dist/*

# -----------------------------------------------------------------------------
# Project Specific
# -----------------------------------------------------------------------------

# Add project specific targets here
