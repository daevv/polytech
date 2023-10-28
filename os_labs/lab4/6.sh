#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <каталог_источник> <каталог_цель>"
    exit 1
fi

source_dir="$1"
destination_dir="$2"

# Используем rsync для синхронизации каталогов
rsync -av --delete --update "$source_dir/" "$destination_dir/"
