# -*- coding: utf-8 -*-
import base64

import requests


class httpbin(object):
    """
    Test library for testing httpbin HTTP requests."""

    def httpbin_get_specific_header(self, header_name):
        """Converts response of http://httpbin.org/get to dict and extracts
        header contents specified by header_name.
        :param header_name: name of header
        :returns: response header contents"""
        response = requests.get('http://httpbin.org/get')
        status_code = response.status_code
        if status_code != 200:
            raise Exception('status code not ok')
        headers_dict = response.json().get('headers', None)
        header_content = headers_dict.get(header_name, None)
        return header_content

    def _httpbin_basic_auth(self, username, password, header_username, header_password):
        """Performs http://httpbin.org/basic-auth/user/passwd request
        with Authorization header, which contains base64 encoded specified username and password.
        :param username: username
        :param password: password
        :param header_username: header username
        :param header_password: header password
        :returns: response for http://httpbin.org/basic-auth/user/passwd request"""
        usrPass = header_username + ':' + header_password
        b64Val = base64.b64encode(usrPass)
        headers = {'Authorization': 'Basic ' + b64Val}
        return requests.get('http://httpbin.org/basic-auth/{}/{}'.format(username, password), headers=headers)

    def httpbin_basic_auth_response_status(self, username, password, header_username, header_password):
        """Returns response status of http://httpbin.org/basic-auth/user/passwd request.
        :param username: username
        :param password: password
        :param header_username: header username
        :param header_password: header password
        :returns: response status"""
        return self._httpbin_basic_auth(username, password, header_username, header_password).status_code

    def httpbin_stream_count_lines(self, n):
        """Returns lines count in http://httpbin.org/stream/n response.
        :param n: number of lines
        :returns: lines count in http://httpbin.org/stream/n response."""
        response = requests.get('http://httpbin.org/stream/{}'.format(n))
        status_code = response.status_code
        if status_code != 200:
            raise Exception('status code not ok')
        return len(response.content.splitlines())

