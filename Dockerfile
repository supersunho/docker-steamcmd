FROM supersunho/fex-emu:ubuntu-24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN  useradd -m -s /bin/bash steam

USER steam   
WORKDIR /home/steam/steamcmd

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
    && FEXBash -c "/home/steam/steamcmd/steamcmd.sh +quit" \
    && mkdir -p ~/.steam/sdk64/ \
    && ln -sf ../../steamcmd/linux64/steamclient.so ~/.steam/sdk64/

WORKDIR /home/steam
ENTRYPOINT ["FEXBash", "/home/steam/steamcmd/steamcmd.sh"]
CMD ["+quit"]