FROM ubuntu:16.04

ENV ROLE_NAME riemann-health
ENV WORKDIR /build/${ROLE_NAME}
ENV PYTHONUNBUFFERED 1

WORKDIR ${WORKDIR}
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install ansible python-setuptools python-pip \
    && apt-get purge -y \
    && apt-get autoremove -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install ansible-lint
ADD . ${WORKDIR}
ADD . /etc/ansible/roles/${ROLE_NAME}
ADD ./test/inventory /etc/ansible/hosts
RUN ansible-galaxy install -r $WORKDIR/test/requirements.yml -p $WORKDIR/test/roles/

# Syntax check
RUN ansible-playbook -i $WORKDIR/test/inventory $WORKDIR/test/test.yml --syntax-check
# Lint check
RUN ansible-lint $WORKDIR/test/test.yml
# Run the playbook
RUN ansible-playbook -i $WORKDIR/test/inventory $WORKDIR/test/test.yml --connection=local
# Idempotency check
RUN ansible-playbook -i $WORKDIR/test/inventory $WORKDIR/test/test.yml --connection=local \
    | grep -q 'changed=0.*failed=0' \
    && (echo 'Idempotence test: pass' && exit 0) \
    || (echo 'Idempotence test: fail' && exit 1)
RUN service riemann-health status
