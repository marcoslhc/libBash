#!/usr/bin/env /bin/bash

MAIL=paperjam@localhost

nice=$(which nice)
dtstp=$(date +%y%m%d.%H%M%S)
tarcm=$(which tar)
rsncm=$(which rsync)
eldir="/mnt/el/linux/gentoo/"
dtdir="/mnt/DATA/linux/gentoo/"
bulst="${HOME}/.backup.txt"
excfl="${HOME}/.exclude.txt"
tarlg="/var/log/tar.${dtstp}.log"
rslog="/var/log/rsync.${dtstp}.log"
archv="/mnt/el/linux/gentoo/${HOSTNAME}.${USER}.${dtstp}.tar.gz"
fparv="/mnt/el/Documents/Videos/full.pj.${dtstp}.tar.gz"

if [[ -d "${eldir}" && -r "${bulst}" && -r "${excfl}"  && -x "${tarcm}" ]]; then

  "${nice}" -n 15 "${tarcm}" --exclude-from="${excfl}" -cvzf "${archv}" $(cat ${bulst}) >> "${tarlg}" 2>&1

  #"${nice}" -n 15 "${tarcm}" --exclude="*/opt/*" --exclude="*/node_modules/*" --exclude="*/ImapMail/*" -cvzf "${fparv}" "${HOME}" >> "${tarlg}" 2>&1

fi

if [[ -d "${eldir}" && -d "${dtdir}" && -x "${rsncm}" ]]; then

  "${nice}" -n 15 "${rsncm}" --verbose --recursive --times --delete --exclude="*/Videos/*" /mnt/el/* /mnt/DATA/ >> "${rslog}" 2>&1

fi
