FROM python:3.7

RUN mkdir -p /home/project/dash_app
WORKDIR /home/project/dash_app

RUN pip install --no-cache-dir numpy scipy

ADD requirements.txt /home/project/dash_app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Dash callbacks are blocking, and also often network-limited
# rather than CPU-limited, so using NUM_WORKERS >> number of
# CPU cores is sensible
ENV NUM_WORKERS=64
ENV MAILTO=YOUR_EMAIL_HERE
ENV PMG_MAPI_KEY=YOUR_MP_API_KEY_HERE

ADD . /home/project/dash_app

CMD gunicorn --workers=$NUM_WORKERS --bind=0.0.0.0 app:server