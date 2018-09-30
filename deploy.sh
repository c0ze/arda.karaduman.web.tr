
hugo --baseURL https://arda.karaduman.web.tr/

s3deploy -source public \
	 -bucket ${AWS_BUCKET_NAME} \
	 -key ${AWS_ACCESS_KEY} \
	 -secret ${AWS_SECRET_KEY} \
	 -region ${AWS_REGION}
