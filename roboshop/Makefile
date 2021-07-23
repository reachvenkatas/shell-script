help:		## Print this message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/://' -e 's/##//'
frontend:	## Install frontend component
	@bash frontend.sh
cart:		## Install frontend component
	@bash cart
catalouge:	## Install catalouge component
	@bash catalouge.sh
mongodb:		## Install mongodb component
	@bash mongodb.sh
mysql:		## Install mysql component
	@echo Installing mysql
payment:		## Install payment component
	@echo Installing payment
rabbitmq:	## Install rabbitmq component
	@echo Installing rabbitmq
redis:		## Install radis component
	@echo Installing redis
shipping:	## Install shipping component
	@echo Installing shipping
user:		## Install user component
	@echo Installing user
databases:	## Install All Databases
databases:	mongodb redis mysql rabbitmq

