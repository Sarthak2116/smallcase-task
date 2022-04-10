# 
FROM python:3.9

# 
WORKDIR /code

# 
COPY ./requirement.txt /code/requirements.txt

# 
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# 
COPY ./server.py /code


EXPOSE 8000
# 
CMD ["uvicorn", "server:app","--host", "0.0.0.0", "--port", "8000"]
