#!/bin/bash
echo '<?xml version="1.0" encoding="UTF-8"?>' > nascar_data.xml
echo '<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd">' >> nascar_data.xml
echo '<error>' $1 '</error>' >>  nascar_data.xml
echo '</nascar_data>' >>  nascar_data.xml
