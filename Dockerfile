ARG base_image
FROM ${base_image}

# Install RVM & Ruby 2.3.1
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
        && curl -sSL https://raw.githubusercontent.com/rvm/rvm/stable/binscripts/rvm-installer | bash -s stable --ruby=2.3.1 \
        && /bin/bash -c "source /usr/local/rvm/scripts/rvm && gem install bundler '--version=1.11.2' --no-format-executable" \
        && echo "source /usr/local/rvm/scripts/rvm" >> ~/.bashrc

# Install dumb-init
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb && \
	echo '34995cf69c88311e9475b4d101186b1d5f4d653f222e41c6e5643ff4e6f56f54 *dumb-init_1.1.3_amd64.deb' | sha256sum --check && \
	dpkg -i dumb-init_*.deb && \
	rm -f dumb-init_*.deb

# Install configgin
RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm && gem install configgin --version 0.18.4"

# Add additional configuration and scripts
ADD monitrc.erb /opt/fissile/monitrc.erb

ADD post-start.sh /opt/fissile/post-start.sh
RUN chmod ug+x /opt/fissile/post-start.sh

ADD rsyslog_conf/etc /etc/
