# pdfpwn

## purpose
Provide Red Team Operators and Pentesters a way to "passively" run a C2 campaign with minimal tools and interaction

## files
- README.md - ...
- tlsserver.sh - automates creating a TLS server to encrypt payloads over the wire
- pdfgen.sh - creates payload, move payload to webserver
- pdfpwn.sh - creates a cron that pulls and parses payload

## usage
- On Attack Box
	- tlsserver.sh (one time)
	- pdfgen.sh
- On Target Box
	- pdfpwn.sh

## how it works
### tlsserver
- updates packages
- installs apache2 package
- enables tls on the http server
- reboots server
### pdfgen
- checks for dependencies
- takes desired PDF name and bash commands as imput
- creates a new PDF with *convert* with the desired name
- encodes the bash commands in base64
- replaces the *ID* metadata with the base64 encoded commands using regex

### pdfpwn
- checks for dependencies
- takes the URL for the PDF as input
- creates a cron that does the following
	- downloads the pdf, updating it if it already exists
	- calclates the md5 checksum for the pdf
	- runs *find* to locate the file (creates a time buffer between download and execution)
	- parses the base64 encoded commands, decodes and executes them
- since it downloads the file from the URL you provide, to change the commands run on the target box, simply use pdfgen to craft a PDF with the new commands and replace the one on the web server

### example
1. run pdfgen, create a payload named 1.pdf
2. pwn target, upload and run pdfpwn, providing the link to 1.pdf
3. the target will download the pdf, parse and executes the commands
4. run pdfgen, create a new payload named 1.pdf and replace the PDF on the web server
5. target will download the new pdf and execute the new commands
