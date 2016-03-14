# Python библиотека для REST сервиса httpbin

Перед началом работы необходимо в корневой директории проекта установить 
и активировать виртуальное окружение python 

```
$ cd robot_httpbin
$ virtualenv venv
$ echo "httpbin_lib_path=\"$(dirname \"${VIRTUAL_ENV}\")/lib\"" >> venv/bin/activate 
$ echo "VIRTUAL_ENV=${VIRTUAL_ENV}:$httpbin_lib_path" >> venv/bin/activate
$ echo "export VIRTUAL_ENV" >> venv/bin/activate
$ source venv/bin/activate
$ pip install -r requirements.txt
```

Запуск тестов robotframework
```
$ pybot test.robot
```
Генерация документации
```
$ cd lib/
$ python -m robot.libdoc httpbin.py ../doc/httpbin_doc.html
```

