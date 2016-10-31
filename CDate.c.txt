// ..................................................  
// CDate class definitions
// Adapted from Hagit Schechter, Jan 2007 for 2014W2 
// ..................................................

#include <iostream>
#include <string>
#include "CDate.h"

CDate::CDate( void ){
	m_year = m_month = m_day = 0;
}

CDate::CDate( int year, int month, int day ){
	setDate( year, month, day );        
}

CDate::CDate( int year, std::string month, int day ){
    m_year=year;
    setDate( year, monthStr2Num(month), day );
}

bool CDate::isValidDate( int year, int month, int day ){
	// TODO you need to fill in the code here        ********
	// comment out the "return false" below 
	// then check the validity of a year, month, and day
	return year >= 0 && month > 0 && month < 13 && isValidDay(year, month, day);
}

bool CDate::isValidDate( int year, std::string month, int day){
	// TODO you need to fill in the code here        ********
	// comment out "return false" below
	// HINT use monthStr2Num to get the month_num 
	// and then reuse another function
    return year >= 0 && monthStr2Num(month) > 0 && monthStr2Num(month) < 13 && isValidDay(year, monthStr2Num(month), day);
}

int CDate::monthStr2Num(std::string month){
        if (month == "January") return 1;
        if (month == "February") return 2;
        if (month == "March") return 3;
        if (month == "April") return 4;
        if (month == "May") return 5;
        if (month == "June") return 6;
        if (month == "July") return 7;
        if (month == "August") return 8;
        if (month == "September") return 9;
        if (month == "October") return 10;
        if (month == "November") return 11;
        else return 12;
}

bool CDate::isValidDay(int year, int month, int day){
	if ((day < 1) || (day > 31)) return false;

	bool valid = false;
	switch (month) { 
		case 1: if ((day > 0) && (day < 32)) valid = true; break;
		case 3: if ((day > 0) && (day < 32)) valid = true; break;
		case 5: if ((day > 0) && (day < 32)) valid = true; break;
		case 7: if ((day > 0) && (day < 32)) valid = true; break;
		case 8: if ((day > 0) && (day < 32)) valid = true; break;
		case 10: if ((day > 0) && (day < 32)) valid = true; break;
		case 12: if ((day > 0) && (day < 32)) valid = true; break;
		case 2: 
			// Don't worry about this code too much.
			// It handles all the leap year rules for February.
			if ((year % 4) != 0) {
				valid = (day <=28);
			} else if ((year % 400) == 0) {
				valid = (day <= 29);
			} else if ((year % 100) == 0) {
				valid = (day <= 28);
			} else {
				valid = (day <= 29);
			}
			break;
		case 4: if ((day > 0) && (day < 31)) valid = true; break;
		case 6: if ((day > 0) && (day < 31)) valid = true; break;
		case 9: if ((day > 0) && (day < 31)) valid = true;  break;
		case 11: if ((day > 0) && (day < 31)) valid = true;  break;
		default: valid = false;
	}
	return valid;
}

void CDate::setDate( int year, int month, int day ){
	if( isValidDate( year, month, day ) ){    
		m_year = year;
		m_month = month;
		m_day = day;
	}
	else {
		m_year = m_month = m_day = 0;
	}
}


void CDate::setDate( int year, std::string month, int day ){
	// TODO you need to fill in the code here        ********
	// HINT use monthStr2Num to get the month_num 
	// and then reuse another function
		if( isValidDate( year, month, day ) ){    
		m_year = year;
		m_month = monthStr2Num(month);
		m_day = day;
	}
	else {
		m_year = m_month = m_day = 0;
	}
}

void CDate::print( void ){
	std::cout << m_day << "/" << m_month << "/" << m_year << std::endl;
}

