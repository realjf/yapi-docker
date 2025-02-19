#! /bin/sh
if [ ! -e "init.lock" ]; then
	sed -i "s/3000/${PORT}/g" "${HOME}/config.json"
	sed -i "s/admin@example.com/${ADMIN_EMAIL}/g" "${HOME}/config.json"
	sed -i "s/yapi-mongo/${DB_SERVER}/g" "${HOME}/config.json"
	sed -i "s/yapi/${DB_NAME}/g" "${HOME}/config.json"
	sed -i "s/27017/${DB_PORT}/g" "${HOME}/config.json"
	yapi install -v "${VERSION}"
	touch init.lock
fi

cd "${HOME}" || exit

node vendors/server/app.js
