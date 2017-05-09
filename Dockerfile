FROM splatform/os-image-ubuntu:trusty

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
        && curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.1 \
        && /bin/bash -c "source /usr/local/rvm/scripts/rvm && gem install bundler '--version=1.11.2' --no-format-executable" \
        && echo "source /usr/local/rvm/scripts/rvm" >> ~/.bashrc

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb && \
	echo '34995cf69c88311e9475b4d101186b1d5f4d653f222e41c6e5643ff4e6f56f54 *dumb-init_1.1.3_amd64.deb' | sha256sum --check && \
	dpkg -i dumb-init_*.deb && \
	rm -f dumb-init_*.deb

RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm && gem install configgin --pre"
