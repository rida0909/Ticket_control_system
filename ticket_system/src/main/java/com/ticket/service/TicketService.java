package com.ticket.service;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.ticket.entity.Customer;
import com.ticket.entity.File;
import com.ticket.entity.Message;
import com.ticket.entity.Request;
import com.ticket.entity.User;
import com.ticket.repository.CustomerRepository;
import com.ticket.repository.FileRepository;
import com.ticket.repository.MessageRepository;
import com.ticket.repository.RequestRepository;
import com.ticket.repository.UserRepository;


@Service
public class TicketService implements ITicketService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Override
	public void addUser(User user) {
		userRepository.save(user);
	}
	
	@Override
	public User loadUser(String username) {
		User user = userRepository.getByUsername(username);
		return user;
	}
	
	@Override
	public User getUser(Integer id) {
		User user = userRepository.findById(id).get();
		return user;
	}
	
	@Override
	public List<User> allUser() {
		List<User> allUser = new ArrayList<>();
		userRepository.findAll().forEach(user -> allUser.add(user));
		return allUser;
	}
	
	@Override
	public List<User> UserByRole(String role) {
		List<User> userRole = new ArrayList<>();
		userRepository.findByRole(role).forEach(user -> userRole.add(user)); //findByRole(role);
		return userRole;
	}
	
	@Autowired
	private CustomerRepository customerRepository;

	@Override
	public void addCustomer(Customer customer) {
		customerRepository.save(customer);
	}
	
	@Override
	public Customer loadCustomer(Integer id) {
		Customer cust = customerRepository.findById(id).get();
		return cust;
	}
	
	@Override
	public List<Customer> allCustomer() {
		List<Customer> allCust = new ArrayList<>();
		customerRepository.findAll().forEach(cust -> allCust.add(cust));
		return allCust;
	}
	
	@Override
	public Customer customerByUsername(String username) {
		Customer cust = new Customer();
		cust = customerRepository.findByName(username);
		return cust;
	}
	
	@Autowired
	private RequestRepository requestRepository;
	
	@Override
	public void addRequest(Request request) {
		requestRepository.save(request);
	}
	
	@Override
	public List<Request> allrequests(){
		List<Request> list = new ArrayList<>();
		requestRepository.findAll().forEach(e -> list.add(e));
		return list;
		
	}
	
	@Override
	public Request getRequest(Integer id) {
		Request req = requestRepository.findById(id).get();
		return req;
	}
	
	@Override
	public void addUser(Request req) {
		requestRepository.save(req);
	}
	
	@Override
	public List<Request> reqByStatus(String status) {
		List<Request> request = new ArrayList<>(); 
		requestRepository.requestByStatus(status).forEach(e -> request.add(e));;
		return request;
	}
	
	@Override
	public List<Request> reqFromDate(Date fromDate) {
		List<Request> request = new ArrayList<>(); 
		requestRepository.requestByFromDate(fromDate).forEach(e -> request.add(e));
		return request;
	}
	
	@Override
	public List<Request> reqToDate(Date toDate) {
		List<Request> request = new ArrayList<>(); 
		requestRepository.requestByToDate(toDate).forEach(e -> request.add(e));
		return request;
	}

	@Override
	public List<Request> reqFromDateTo(Date fromDate, Date toDate) {
		List<Request> request = new ArrayList<>(); 
		requestRepository.requestByFromDateTo(fromDate, toDate).forEach(e -> request.add(e));
		return request;
	}

	
	@Override
	public List<Request> reqByAssignedUser(Integer assignedUser) {
		List<Request> req = new ArrayList<>();
		requestRepository.getByUser(assignedUser).forEach(e -> req.add(e));
		return req;
	}
	
	@Override
	public List<Request> reqByIssueType(String issueType) {
		List<Request> req = new ArrayList<>();
		requestRepository.getByType(issueType).forEach(e -> req.add(e));
		return req;
	}
	
	@Override
	public List<Request> reqByIssueCategory(String issueCategory) {
		List<Request> req = new ArrayList<>();
		requestRepository.getByCategory(issueCategory).forEach(e -> req.add(e));
		return req;
	}
	
	@Override
	public List<Request> reqByCustomerId(Integer cid){
		List<Request> req = new ArrayList<>();
		requestRepository.getBycid(cid).forEach( e -> req.add(e));
		return req;
	}
	
	@Autowired
	private MessageRepository messageRepository;
	
	@Override
	public void addMessage(Message message) {
		messageRepository.save(message);
	}
	
	@Override
	public List<Message> allMessages(){
		List<Message> list = new ArrayList<>();
		messageRepository.findAll().forEach(e -> list.add(e));
		return list;
	}
	
	 @Autowired
	    FileRepository fileRepository;
	
	 @Override
	 public File saveFile(MultipartFile file, Integer rid) {
		 
		  String docname = file.getOriginalFilename();
		  
		  try {
			  File doc = new File(docname, rid, file.getContentType(),file.getBytes());
			  return fileRepository.save(doc);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
		  return null;
	  }
	 
	 @Override
	 public File saveDescFile(MultipartFile file, Integer rid) {
		 
		  String docname = "description_".concat(file.getOriginalFilename());
		  
		  try {
			  File doc = new File(docname, rid, file.getContentType(),file.getBytes());
			  return fileRepository.save(doc);
		  }
		  catch(Exception e) {
			  e.printStackTrace();
		  }
		  return null;
	  }
	 
	 @Override
	  public Optional<File> getFile(Integer fileId) {
		  return fileRepository.findById(fileId);
	  }
	 
	 @Override
	  public List<File> getFiles(){
		  return (List<File>) fileRepository.findAll();
	  }
	 
	 @Override
	  public List<File> getMidFiles(Integer id){
		  return (List<File>) fileRepository.findByMid(id);
	  }
	  
	
}
