package com.carlosx.rest.castor;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.exolab.castor.mapping.GeneralizedFieldHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DateTimeFieldHandler extends GeneralizedFieldHandler {

	private static Logger logger = LoggerFactory.getLogger(DateTimeFieldHandler.class);
	private static String dateFormatPattern;
	
	@Override
	public Object convertUponGet(Object value) {
		Date dateTime = (Date) value;
	    return format(dateTime);
	}

	@Override
	public Object convertUponSet(Object value) {
		String dateTimeString = (String) value;
	    return parse(dateTimeString);
	}

	@Override
	public Class getFieldType() {
		return Date.class;
	}

    protected static String format(final Date  dateTime) {
        String dateTimeString = "";
        if (dateTime != null) {
          SimpleDateFormat sdf = new SimpleDateFormat(dateFormatPattern);
          dateTimeString = sdf.format(dateTime);
        }
        return dateTimeString;
     }
    
     protected static Date  parse(final String dateTimeString) {
        Date dateTime = new Date();
        if (dateTimeString != null) {
          SimpleDateFormat sdf =
             new SimpleDateFormat(dateFormatPattern);
          try {
             dateTime = sdf.parse(dateTimeString);
          } catch (ParseException e) {
             logger.error("Not a valida date:" + dateTimeString, e);
          }
        }
        return dateTime;
     }
}