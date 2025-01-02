#!/usr/bin/env python

from os import environ, path, makedirs

from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer

def check_env():
	has_error = False
	envs = ['FTP_USER',
			'FTP_PASSWORD',
			'FTP_DIR']
	for env in envs:
		if env not in environ:
			print('You need to specify %s' % env)
			has_error = True
	if has_error:
		exit(1)

def main():
	check_env()

	if not path.isdir(environ['FTP_DIR']):
		makedirs(environ['FTP_DIR'])

	authorizer = DummyAuthorizer()

	authorizer.add_user(environ['FTP_USER'],
						environ['FTP_PASSWORD'],
						environ['FTP_DIR'], perm='elradfmwMT')

	handler = FTPHandler
	handler.authorizer = authorizer
	handler.permit_foreign_addresses = True
	handler.passive_ports = range(5000, 5020)

	handler.banner = environ.get('FTP_BANNER', 'pyftpdlib based ftpd ready.')

	address = ('', 21)
	server = FTPServer(address, handler)

	server.max_cons = environ.get('FTP_MAX_CONS', 256)
	server.max_cons_per_ip = environ.get('FTP_CONS_PER_IP', 5)

	server.serve_forever()

if __name__ == '__main__':
	main()
