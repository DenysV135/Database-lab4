from setuptools import setup, find_packages

setup(
    name='mydb_backend',
    version='1.0',
    description='Back-End project for Netflix-like DB',
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'Flask',
        'Flask-SQLAlchemy',
        'mysql-connector-python',
        'PyYAML'
    ],
)