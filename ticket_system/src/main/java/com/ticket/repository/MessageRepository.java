package com.ticket.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ticket.entity.Message;

@Repository
public interface MessageRepository extends CrudRepository<Message, Integer> {

}
