help:		# help messgae
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

frontend:	# Install frontend
	@sh components/1-frontend.sh

mongodb:	# Install mongodb
	@sh components/2-mongodb.sh

catalogue:	# Installl catalogue
	@sh components/3-catalogue.sh

redis:		#Install redis
	@sh components/4-redis.sh

user:		#Install user
	@sh components/5-user.sh

cart:		# Install cart
	@sh components/6-cart.sh

mysql:		# Install mysql
	@sh components/7-mysql.sh

shipping:	# Install shipping
	@sh components/8-shipping.sh

rabbitmq:	#Install rabbitmq
	@sh components/9-rabbitmq.sh

payment:	#Install payment
	@sh components/10-payment.sh

dispatch:	#Install dispatch
	@sh components/11-dispatch.sh