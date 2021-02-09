FROM python:2


RUN apt-get update \
    && apt-get install -y \
        build-essential \
        git \
        make \
        wget \
        ffmpeg \
        portaudio19-dev \
        python-pyaudio #\
        #alsa-base \
        #alsa-utils \
        #pulseaudio

#RUN deb http://cz.archive.ubuntu.com/ubuntu raring main



#COPY requirements.txt ./

WORKDIR /

RUN pip install matplotlib
RUN pip install termcolor
RUN pip install scipy
RUN pip install pydub
RUN pip install PyAudio
#RUN pip install -r requirements.txt


COPY . /

#MAKE WAY
RUN git clone https://github.com/itspoma/audio-fingerprint-identifying-python.git
RUN cd /audio-fingerprint-identifying-python && make clean reset
RUN cd /audio-fingerprint-identifying-python && make tests
RUN mkdir audio-fingerprint-identifying-python/mp3
RUN cp BeeGeesStayingAlive.mp3 audio-fingerprint-identifying-python/mp3
RUN cd /audio-fingerprint-identifying-python && make fingerprint-songs

#OTHER WAY
# RUN git clone https://github.com/JosephMawanda/audio_recogition_system
# RUN cd /audio_recogition_system && make clean reset
# RUN cd /audio_recogition_system && make tests
# RUN mkdir audio_recogition_system/mp3
# RUN cp BeeGeesStayingAlive.mp3 audio_recogition_system/mp3
# RUN python audio_recogition_system/collect-fingerprints-of-songs.py



ENTRYPOINT [ "python" ]

CMD [ "app.py" ]