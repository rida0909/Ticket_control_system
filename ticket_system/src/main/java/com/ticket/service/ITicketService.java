package com.ticket.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.web.multipart.MultipartFile;

import com.ticket.entity.Customer;
import com.ticket.entity.File;
import com.ticket.entity.Message;
import com.ticket.entity.Request;
import com.ticket.entity.User;

public interface ITicketService {

	void addUser(User user);
	void addCustomer(Customer customer);
	User loadUser(String username);
	Customer loadCustomer(Integer id);
	void addRequest(Request request);
	Request getRequest(Integer id);
	void addMessage(Message message);
	List<Message> allMessages();
	List<Request> allrequests();
	void addUser(Request req);
	Optional<File> getFile(Integer id);
	List<File> getFiles();
	File saveFile(MultipartFile file, Integer rid);
	List<File> getMidFiles(Integer id);
	List<Request> reqByAssignedUser(Integer assignedUser);
	List<Request> reqFromDateTo(Date fromDate, Date toDate);
	List<Request> reqByStatus(String status);
	List<Request> reqFromDate(Date fromDate);
	List<Request> reqToDate(Date toDate);
	User getUser(Integer id);
	List<Request> reqByIssueType(String issueType);
	List<Request> reqByIssueCategory(String issueType);
	List<User> allUser();
	List<Customer> allCustomer();
	List<Request> reqByCustomerId(Integer cid);
	Customer customerByUsername(String username);
	List<User> UserByRole(String role);
	File saveDescFile(MultipartFile file, Integer rid);
}
