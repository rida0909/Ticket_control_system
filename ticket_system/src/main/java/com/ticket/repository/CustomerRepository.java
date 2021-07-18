package com.ticket.repository;


import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ticket.entity.Customer;

@Repository
public interface CustomerRepository extends CrudRepository<Customer, Integer>{

	Customer findByName(String name);
}
