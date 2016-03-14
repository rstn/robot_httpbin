*** Settings ***
Documentation     Test cases using the data-driven testing approach.
Library           lib/httpbin.py

*** Variables ***
${VALID_USER}=	user
${VALID_PASSWORD}=	passwd

*** Test Cases ***

Test Accept header in /get response
	[Documentation]	test Accept header contents for /get
	...				set missing header name in /get response
	${result}=	Httpbin Get Specific Header	Accept
	Should be equal		${result}	*/*
	${result}=	Httpbin Get Specific Header		AcceptAccept
	Should not be equal		${result}	*/*

Test lines count in response /stream
	[Documentation]	test lines count for stream respons
	...				set number of lines as url parameter
	${result}=	Httpbin Stream Count Lines	3
	Should be equal as strings	${result}	3
	${result}=	Httpbin Stream Count Lines	50
	Should be equal as strings	${result}	50
	${result}=	httpbin_stream_count_lines	4
	Should not be equal as strings	${result}	3

#Data-driven tests for basic_auth/
Test response status for successful and unsuccessful response from /basic_auth
	[Documentation]	test basic auth
	...				set username and password, headers username and password
	[Template]	Get Auth Response Status
	${VALID_USER}	${VALID_PASSWORD}	${VALID_USER}	${VALID_PASSWORD}	200
	invalid			${VALID_PASSWORD}	${VALID_USER}	${VALID_PASSWORD}	401
	${VALID_USER}	invalid				${VALID_USER}	${VALID_PASSWORD}	401
	invalid			whatever			${VALID_USER}	${VALID_PASSWORD}	401
	${EMPTY}		${VALID_PASSWORD}	${VALID_USER}	${VALID_PASSWORD}	404
	${VALID_USER}	${EMPTY}			${VALID_USER}	${VALID_PASSWORD}	404
	${EMPTY}		${EMPTY}			${VALID_USER}	${VALID_PASSWORD}	404
	${VALID_USER}	${VALID_PASSWORD}	invalid			${VALID_PASSWORD}	401
	${VALID_USER}	${VALID_PASSWORD}	${VALID_USER}	invalid				401
	${VALID_USER}	${VALID_PASSWORD}	invalid			whatever			401
	${VALID_USER}	${VALID_PASSWORD}	${EMPTY}		${VALID_PASSWORD}	401
	${VALID_USER}	${VALID_PASSWORD}	${VALID_USER}	${EMPTY}			401
	${VALID_USER}	${VALID_PASSWORD}	${EMPTY}		${EMPTY}			401

*** Keywords ***
Get Auth Response Status
	[Documentation]		Test response status for authorization request
	[Arguments]		${username}	${password}	${header_username}	${header_password}	${expected}
	${result}=	Httpbin Basic Auth Response Status	${username}	${password}	${header_username}	${header_password}
	Should Be Equal as strings	${result}	${expected}
