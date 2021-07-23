help:		## Print this message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/://' -e 's/##//'
frontend:	## Install frontend component
	@bash frontend.sh
cart:		## Install frontend component
	@bash cart.sh
catalouge:	## Install catalouge component
	@bash catalouge.sh
mongodb:		## Install mongodb component
	@bash mongodb.sh
mysql:		## Install mysql component
	@bash mysql.sh
payment:		## Install payment component
	@bash payment.sh
rabbitmq:	## Install rabbitmq component
	@bash rabbitmq.sh
redis:		## Install radis component
	@bash redis.sh
shipping:	## Install shipping component
	@bash shipping.sh
user:		## Install user component
	@bash user.sh
databases:	## Install All Databases
databases:	mongodb redis mysql rabbitmq

