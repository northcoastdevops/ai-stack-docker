#!/bin/bash

# Reload nginx after certificate renewal
docker exec nginx nginx -s reload 