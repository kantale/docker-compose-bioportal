FROM debian
EXPOSE 55555:55555

RUN mkdir -p /opt/mgrep/dictionary

COPY resources/CaseFolding.txt /opt/mgrep/
COPY resources/word_divider.txt /opt/mgrep/

COPY mgrep /opt/mgrep
COPY run_mgrep_blocking /opt/mgrep/

VOLUME /opt/mgrep/dictionary

CMD ["/opt/mgrep/run_mgrep_blocking"]
