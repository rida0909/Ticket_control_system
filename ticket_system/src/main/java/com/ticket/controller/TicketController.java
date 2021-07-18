package com.ticket.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.ticket.entity.Customer;
import com.ticket.entity.File;
import com.ticket.entity.Message;
import com.ticket.entity.Request;
import com.ticket.entity.User;
import com.ticket.service.ITicketService;


@Controller
public class TicketController {
	
	private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
	 
	@RequestMapping("/")
	public String home(Map<String, Object> model) {
	 
	    LOGGER.debug("This is a debug message");
	    LOGGER.info("This is an info message");
	    LOGGER.warn("This is a warn message");
	    LOGGER.error("This is an error message");
	 
	    model.put("message", "HowToDoInJava Reader !!");
	    return "home";
	}
	
	public Integer cid;
	public Integer userId;
	
	@Autowired
	private ITicketService ticketService;
	
	@RequestMapping("/home")
	public ModelAndView home(User user) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("home");
		return mv;
	}
	
	@RequestMapping("/sign-up")
	public ModelAndView add(@RequestParam("username") String us, @RequestParam("password1") String pass1, 
			@RequestParam("password2") String pass2, @RequestParam("email") String email, 
			@RequestParam("mobile") Long mob, @RequestParam(value = "role", required = false) String role) {
			
			ModelAndView mv = new ModelAndView();
			if(pass1.contentEquals(pass2)) {
			User user = new User();
			user.setUsername(us);
			user.setPassword1(pass1);
			user.setEmail(email);
			user.setMobile(mob);
			user.setStatus("active");
			if(role != null) {
				user.setRole(role);
			}
			else {
				user.setRole("cust");
			}
			System.out.println(role);
			ticketService.addUser(user);
			
			if(role != null) {
				return new ModelAndView(new RedirectView("admin"));
			}
			
			else {
				Integer customerId = user.getId();
				return new ModelAndView(new RedirectView("customer-page?cid=" + customerId));	
			}
			}
			else {
				return new ModelAndView("home");
			}
	}
	
	@RequestMapping("/customer-page")
	public ModelAndView customerPage(@RequestParam("cid") Integer customerId) {
		ModelAndView mv = new ModelAndView();
		List<Request> requests = new ArrayList<>();
		requests = ticketService.reqByCustomerId(customerId);
		String customerName = ticketService.getUser(customerId).getUsername();
		List desc = new ArrayList<>();
		List requestId = new ArrayList<>();
		List status = new ArrayList<>();
		List date = new ArrayList<>();
		int i;
		for(i = 0; i < requests.size(); i++) {
			desc.add(requests.get(i).getDesc());
			requestId.add(requests.get(i).getId());
			status.add(requests.get(i).getStatus());
			SimpleDateFormat dateFor = new SimpleDateFormat("dd/MM/yyyy");
			String stringDate = dateFor.format(requests.get(i).getDate());
			date.add(stringDate);
		}
		mv.addObject("des", desc);
		mv.addObject("rid", requestId);
		mv.addObject("sts", status);
		mv.addObject("dt", date);
		mv.addObject("cid", customerId);
		mv.addObject("custName", customerName);
		mv.setViewName("customer");
		return mv;
	}
	
	@RequestMapping("/customer")
	public ModelAndView regCustomer(@RequestParam("username") String name, @RequestParam("password") String pass) {
		ModelAndView mv = new ModelAndView();
		User user = ticketService.loadUser(name);
		
		if (user.getPassword1().contentEquals(pass)) {
			Integer id = user.getId();
			cid = id;
			return new ModelAndView (new RedirectView("customer-page?cid=" + id));
		}
		else {
			mv.setViewName("home");
		}
		
		return mv;
	}
	
	@RequestMapping("/sign-in")
	public ModelAndView login(@RequestParam("username") String name, @RequestParam("password") String pass) {
		ModelAndView mv = new ModelAndView();
		User user = ticketService.loadUser(name);
		String role = user.getRole();
		
		if (user.getPassword1().contentEquals(pass)) {
			Integer id = user.getId();
			if(role.contentEquals("cust")) {
				return new ModelAndView (new RedirectView("customer-page?cid=" +id));
			}
			if(role.contentEquals("staff")) {
				return new ModelAndView (new RedirectView("user-page?id=" +id));
			}
			if(role.contentEquals("admin")) {
				return new ModelAndView (new RedirectView("admin"));
			}
		}
		else {
			mv.setViewName("home");
		}
		
		return mv;
	}
	
	@RequestMapping("/user-page")
	public ModelAndView userPage(@RequestParam("id") String id) {
		ModelAndView mv = new ModelAndView();
		userId = Integer.valueOf(id);
		String userName = (ticketService.getUser(userId)).getUsername();
		List<Request> list = ticketService.allrequests();
		List desc = new ArrayList<>();
		List rid = new ArrayList<>();
		List sts = new ArrayList<>();
		List type = new ArrayList<>();
		List category = new ArrayList<>();
		List dt = new ArrayList<>();
		List cid = new ArrayList<>();
		List cName = new ArrayList<>();
		List<User> allCustomers = new ArrayList<>();
		List allCustomerNames = new ArrayList<>();
		List allCustomerIds = new ArrayList<>();
		allCustomers = ticketService.UserByRole("cust");
		int c;
		for(c = 0; c < allCustomers.size(); c++) {
			allCustomerNames.add(allCustomers.get(c).getUsername());
			allCustomerIds.add(allCustomers.get(c).getId());
		}
		User cust = new User();
		int i;
		for(i=0; i<list.size(); i++) {
			if((list.get(i).getUser()) == userId) {
				desc.add(list.get(i).getDesc());
				rid.add(list.get(i).getId());
				sts.add(list.get(i).getStatus());
				type.add(list.get(i).getType());
				category.add(list.get(i).getCategory());
				
				SimpleDateFormat dateFor = new SimpleDateFormat("dd/MM/yyyy");
				String stringDate = dateFor.format(list.get(i).getDate());
				dt.add(stringDate);

				cid.add(list.get(i).getCid());
				cust = ticketService.getUser(list.get(i).getCid());
				cName.add(cust.getUsername());
			}
		}
		mv.addObject("custName",cName);
		mv.addObject("custId",cid);
		mv.addObject("sts",sts);
		mv.addObject("type",type);
		mv.addObject("category",category);
		mv.addObject("dt",dt);
		mv.addObject("desc", desc);
		mv.addObject("rid", rid);
		mv.addObject("uid", userId);
		mv.addObject("userName", userName);
		mv.addObject("allCustomerNames", allCustomerNames);
		mv.addObject("allCustomerIds", allCustomerIds);
		mv.setViewName("support");
		return mv;
	}
	
	@RequestMapping("/create-request")
	public ModelAndView request(@RequestParam("description") String des,@RequestParam(value = "files", required = false) MultipartFile[] files,
			@RequestParam("cid") Integer customerId, @RequestParam(value = "action", required = false) String action, 
			@RequestParam(value = "uid", required = false) String uid) {
		ModelAndView mv = new ModelAndView();
		Request req = new Request();
		req.setDesc(des);
		req.setStatus("created");
		req.setCid(customerId);
		ticketService.addRequest(req);
		Integer rid = req.getId();
		for (MultipartFile file: files) {
			if(!file.isEmpty()) {
			ticketService.saveDescFile(file, rid);
			}
		}
		if(action.contentEquals("staff")) {
			return new ModelAndView (new RedirectView("/user-page?id=" + uid));
		}
		else if(action.contentEquals("admin")) {
			return new ModelAndView (new RedirectView("/admin"));
		}
		else {
		return new ModelAndView (new RedirectView("/customer-page?cid=" + customerId));
		}
	}
	
	@RequestMapping("/user-request")
	public ModelAndView requests(@RequestParam("id") Integer requestId, @RequestParam("action") String action) {
		boolean isUserLive;
		if(cid == null) {
			isUserLive = true;
		}else {
			isUserLive = false;
		}
		ModelAndView mv = new ModelAndView();
		Request req = ticketService.getRequest(requestId);
		String issueDescription = req.getDesc();
		String issueStatus = req.getStatus();	
		String issueType = req.getType();
		String issueCateg = req.getCategory();
		SimpleDateFormat dateForm = new SimpleDateFormat("dd/MM/yyyy");
		String reqDate = dateForm.format(req.getDate());
		Integer uid = req.getUser();
		Integer cid = req.getCid();
		String user;
		if(uid != null) {
		user = (ticketService.getUser(uid)).getUsername();
		}
		else {
		user = null;
		}
		List<File> files = ticketService.getMidFiles(requestId);
		List attFiles = new ArrayList<>();
		List<Integer> mid = new ArrayList<>();		
		List<Message> msgList = ticketService.allMessages();
		List<Object> chats = new ArrayList<>();
		List<Object> whoseMsg = new ArrayList<>();
		List<Object> msgTime = new ArrayList<>();
		List<User> allUsers = ticketService.UserByRole("staff");
		List allUserNames = new ArrayList<>();
		List allUserIds = new ArrayList<>();
		JSONObject msgObj = new JSONObject();
        JSONArray fileArray = new JSONArray();
        JSONArray fileIds = new JSONArray();
        JSONArray msgArray = new JSONArray();
        for(int i = 0; i < msgList.size() ; i++) {
			
			if(msgList.get(i).getRid() == requestId) {
				chats.add(msgList.get(i).getMsg());
				whoseMsg.add(msgList.get(i).getWhoseMsg());
				msgTime.add(msgList.get(i).getDate());
				msgObj = new JSONObject();
				msgObj.put("msg", msgList.get(i).getMsg());				
				if((ticketService.getMidFiles(msgList.get(i).getId())).size() != 0) {
					List<File> someFiles = ticketService.getMidFiles(msgList.get(i).getId());
					msgObj.put("msg", msgList.get(i).getMsg());
					fileArray = new JSONArray();
					fileIds = new JSONArray();
					for(int k = 0; k < someFiles.size(); k++) {
						fileArray.put(someFiles.get(k).getFileName());
						fileIds.put(someFiles.get(k).getId());
					}
					msgObj.put("filename", fileArray);					
					msgObj.put("fileid", fileIds);					
				}else {
					fileArray = new JSONArray();
					msgObj.put("filename", fileArray);
					fileIds = new JSONArray();
					msgObj.put("fileid", fileIds);
				}
				msgArray.put(msgObj);				
			}
			
		}

		int k;
		for(k = 0; k < files.size(); k++) {
			if((files.get(k).getFileName()).startsWith("description")) {
				attFiles.add(files.get(k).getFileName());
			}
		}
		
		int u;
		for(u = 0 ; u < allUsers.size(); u++) {
			allUserNames.add(allUsers.get(u).getUsername());
			allUserIds.add(allUsers.get(u).getId());
		}
		mv.addObject("attFiles", attFiles);
		mv.addObject("msgArray", msgArray);
		mv.addObject("uid", uid);
		mv.addObject("desc", issueDescription);
		mv.addObject("rid", requestId);
		mv.addObject("msg", chats);
		mv.addObject("dt", msgTime);
		mv.addObject("whose_msg", whoseMsg);
		mv.addObject("sts", issueStatus);	
		mv.addObject("issueType", issueType);	
		mv.addObject("issueCateg", issueCateg);	
		mv.addObject("username", user);	
		mv.addObject("rqDate", reqDate);	
		mv.addObject("isUser", isUserLive);
		mv.addObject("action", action);
		mv.addObject("cid", cid);
		mv.addObject("allUserNames", allUserNames);
		mv.addObject("allUserIds", allUserIds);
		mv.setViewName("user_requests");
		return mv;
	}
	
	@RequestMapping("/set-type")
	public ModelAndView typeAndCate(@RequestParam("id") String id, @RequestParam("type") String type, 
			@RequestParam("cat") String category, @RequestParam("action") String action) {
		Integer rid = Integer.valueOf(id);
		Request req = ticketService.getRequest(rid);
		req.setCategory(category);
		req.setType(type);
		ticketService.addRequest(req);
		return new ModelAndView (new RedirectView("/user-request?id=" + rid + "&&action=" + action));
	}
	
	@RequestMapping("/store-message")
	public ModelAndView sendMsg(@RequestParam("message") String message, @RequestParam("id") String id, 
			@RequestParam("uid") String uid, @RequestParam(value = "files", required = false) MultipartFile[] files,
			@RequestParam("action") String action
			) {
		Message newMessage = new Message();
		newMessage.setMsg(message);
		if(action.contentEquals("customer")) {
			newMessage.setWhoseMsg("c");
		}else if (action.contentEquals("staff")){
			newMessage.setWhoseMsg("u");
		}else if(action.contentEquals("admin")) {
			newMessage.setWhoseMsg("a");
		}
		
		Integer requestId = Integer.valueOf(id);
		Integer userId = Integer.valueOf(uid);
		newMessage.setRid(requestId);
		newMessage.setUid(userId);
		ticketService.addMessage(newMessage);
		
		Integer mid = newMessage.getId();
		for (MultipartFile file: files) {
			if(!file.isEmpty()) {
			ticketService.saveFile(file, mid);
			}
		}
		return new ModelAndView(new RedirectView("user-request?id=" + requestId + "&&action=" + action));
	}
	
	@RequestMapping("/admin")
	public ModelAndView adminPannel(@RequestParam(value = "filter", required = false) String filter,
	@RequestParam(value = "from_date", required = false)String fromDate,
			@RequestParam(value = "to_date", required = false)String toDate,
			@RequestParam(value = "filter_status", required = false)String fStatus,
			@RequestParam(value = "filter_user_id", required = false)String fUserId,
			@RequestParam(value = "filter_issue_type", required = false)String fIssueType,
			@RequestParam(value = "filter_issue_category", required = false)String fIssueCategory) throws Exception{
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		List<Request>  req = null, allReq = null;
		List<User> allUsers = null;
		if(filter != null) {
			req = listByFilter(filter, fromDate, toDate, fStatus, fUserId, fIssueType, fIssueCategory);
		}
		List<User> allCustomer = null;
		List<Object> allUserId = new ArrayList<>();
		List<Object> allCustomerName = new ArrayList<>();
		List<Object> allUsername = new ArrayList<>();
		allUsers = ticketService.UserByRole("staff");
		allCustomer = ticketService.UserByRole("cust");
		if(allUsers.size() != 0) {
			for(int i = 0; i< allUsers.size(); i++) {
				if(allUsers.get(i).getId() != null) {
					if(allUsers.get(i).getUsername() != "admin") {
						allUserId.add(allUsers.get(i).getId());
						allUsername.add(allUsers.get(i).getUsername());
					}
				}
			}
		}
		ModelAndView admin = new ModelAndView();
		allReq = ticketService.allrequests();
		List<Object> requestId = new ArrayList<>();
		List<Object> userId = new ArrayList<>();
		List<Object> description = new ArrayList<>();
		List<Object> customerId = new ArrayList<>();
		List<Object> allAssignedUser = new ArrayList<>();
		List<Object> issueType = new ArrayList<>();
		List<Object> issueCategory = new ArrayList<>();
		List<Object> createdDate = new ArrayList<>();
		List<Object> closedDate = new ArrayList<>();
		List<Object> status = new ArrayList<>();
		List allCustomerNames = new ArrayList<>();
		List allCustomerIds = new ArrayList<>();
		int c;
		for(c = 0; c < allCustomer.size(); c++) {
			allCustomerNames.add(allCustomer.get(c).getUsername());
			allCustomerIds.add(allCustomer.get(c).getId());
		}
		if(req != null) {
			for(int i = 0; i < req.size(); i++) {
				requestId.add(req.get(i).getId());
				customerId.add(req.get(i).getCid());
				description.add(req.get(i).getDesc());
				allAssignedUser.add(req.get(i).getUser());
				userId.add(req.get(i).getUser());
				issueType.add(req.get(i).getType());
				issueCategory.add(req.get(i).getCategory());
				status.add(req.get(i).getStatus());
				if(req.get(i).getDate() != null)
					createdDate.add(formatter.format(req.get(i).getDate()));
				else
					createdDate.add(req.get(i).getDate());
				if(req.get(i).getClose() != null)
					closedDate.add(formatter.format(req.get(i).getClose()));
				else
					closedDate.add(req.get(i).getClose());
			}
		}
		else {
			for(int i = 0; i < allReq.size(); i++) {
					requestId.add(allReq.get(i).getId());
					customerId.add(allReq.get(i).getCid());
					description.add(allReq.get(i).getDesc());
					allAssignedUser.add(allReq.get(i).getUser());
					userId.add(allReq.get(i).getUser());
					issueType.add(allReq.get(i).getType());
					issueCategory.add(allReq.get(i).getCategory());
					status.add(allReq.get(i).getStatus());
					if(allReq.get(i).getDate() != null)
						createdDate.add(formatter.format(allReq.get(i).getDate()));
					else
						createdDate.add(allReq.get(i).getDate());
					if(allReq.get(i).getClose() != null)
						closedDate.add(formatter.format(allReq.get(i).getClose()));
					else
						closedDate.add(allReq.get(i).getClose());
			}
		}
		for(int i = 0; i < allAssignedUser.size(); i++) {
			if(allAssignedUser.get(i) != null) {
				for(int index = 0; index < allUsers.size(); index++) {
					if(allAssignedUser.get(i) == allUsers.get(index).getId()) {
						allAssignedUser.set(i, allUsers.get(index).getUsername());
					}
				}
			}
		}
		for(int i = 0; i < customerId.size(); i++) {
			for(int j = 0; j < allCustomer.size(); j++) {
				if(allCustomer.get(j).getId() == customerId.get(i)) {
					allCustomerName.add(allCustomer.get(j).getUsername());
				}				
			}	
		}
		System.out.println(customerId);
		System.out.println(allCustomerName);
		admin.addObject("user", userId);
		admin.addObject("id", requestId);
		admin.addObject("desc", description);
		admin.addObject("cust", customerId);
		admin.addObject("custName", allCustomerName);
		admin.addObject("allUserId", allUserId);
		admin.addObject("allUsername", allUsername);
		admin.addObject("assignedUsername", allAssignedUser);
		admin.addObject("issueType", issueType);
		admin.addObject("issueCategory", issueCategory);
		admin.addObject("createdDate", createdDate);
		admin.addObject("closedDate", closedDate);
		admin.addObject("issueStatus", status);
		admin.addObject("allCustomerNames", allCustomerNames);
		admin.addObject("allCustomerIds", allCustomerIds);
		admin.setViewName("admin");
		return admin;
	}
	
	@RequestMapping("/assi-user")
	public ModelAndView assign(@RequestParam("id") String rid, @RequestParam("user") String uid) {
		ModelAndView mv = new ModelAndView();
		int id = Integer.parseInt(rid);
		int user = Integer.parseInt(uid);
		Request request = ticketService.getRequest(id);
		request.setUser(user);
		request.setStatus("assigned");
		ticketService.addUser(request);
		
		return new ModelAndView(new RedirectView("admin"));
	}
	
	@RequestMapping("/assi-anotheruser")
	public ModelAndView anotherUser(@RequestParam("id") String rid, @RequestParam("assigned_user") String uid) {
		ModelAndView mv = new ModelAndView();
		int id = Integer.parseInt(rid);
		int user = Integer.parseInt(uid);
		Request request = ticketService.getRequest(id);
		request.setUser(user);
		request.setStatus("assigned");
		ticketService.addUser(request);
		
		return new ModelAndView(new RedirectView("/user-page?id=" +userId));
	}
	
	@RequestMapping("/resolved")
	public ModelAndView resolved(@RequestParam("id") String rid) {
		ModelAndView mv = new ModelAndView();
		int id = Integer.parseInt(rid);
		Date close = new Date();
		Request request = ticketService.getRequest(id);
		request.setStatus("resolved");
		request.setClose(close);
		ticketService.addUser(request);
		Integer uid = userId;
		return new ModelAndView (new RedirectView("user-page?id=" +uid));
		
		
	}

	
	
	
	
	@RequestMapping("/uploadFiles")
	public ModelAndView uploadMultipleFiles(@RequestParam("rid") String rid, @RequestParam("files") MultipartFile[] files) {
		Integer reqId = Integer.parseInt(rid);
		for (MultipartFile file: files) {
			ticketService.saveFile(file, reqId);
			
		}
		return new ModelAndView(new RedirectView("user-request"), "id", reqId);
	}
	@RequestMapping("/downloadFile/{fileId}")
	public ResponseEntity<ByteArrayResource> downloadFile(@PathVariable Integer fileId){
		File doc = ticketService.getFile(fileId).get();
		return ResponseEntity.ok()
				.contentType(MediaType.parseMediaType(doc.getFileType()))
				.header(HttpHeaders.CONTENT_DISPOSITION,"attachment:filename=\""+doc.getFileName()+"\"")
				.body(new ByteArrayResource(doc.getData()));
	}
	@RequestMapping("/try")
	public ModelAndView trial() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("NewFile");
		return mv;
	}
	
	@RequestMapping("/hellouser")
	 public ModelAndView usera() {
	 
	  String helloWorldMessage = "Hello world from java2blog!";
	  return new ModelAndView("user", "message", helloWorldMessage);
	 }
	
	
	public List<Request> listByFilter(String filter, String fromDate, String toDate, String fStatus , String fUserId,
			String fIssueType, String fIssueCategory) throws ParseException{
		List<Request> req = null, reqByIssueType = null, reqByIssueCategory = null;
		Date fromD = null, toD = null;
		if(filter.contentEquals("date")) {
			if(((toDate != null) && (toDate != "")) && ((fromDate != null) && (fromDate != ""))) {
				fromD = new SimpleDateFormat("yyyy-MM-dd").parse(fromDate);
				toD = new SimpleDateFormat("yyyy-MM-dd").parse(toDate);
				req = ticketService.reqFromDateTo(fromD, toD);
			}else if((fromDate != null) && (fromDate != "")) {
				fromD = new SimpleDateFormat("yyyy-MM-dd").parse(fromDate);
				req = ticketService.reqFromDate(fromD);
			}else if((toDate != null) && (toDate != "")) {
				toD = new SimpleDateFormat("yyyy-MM-dd").parse(toDate);
				req = ticketService.reqToDate(toD);
			}else {
				req = null;
			}
		}else if(filter.contentEquals("status")) {
			if((fStatus != null) && (fStatus != "")) {
				req = ticketService.reqByStatus(fStatus);
				
			}else
				req = null;
		}else if(filter.contentEquals("user")) {
			if((fUserId != null) && (fUserId != "")) {
				if(fUserId != "none") {
					req = ticketService.reqByAssignedUser(Integer.valueOf(fUserId));
				}else 
					req = null;
			}
		}else if(filter.contentEquals("issue")) {
			if((fIssueType != null) && (fIssueType != "")) {
				if(fIssueType.contentEquals("none")) {
					fIssueType = null;
				}else {
					reqByIssueType =  ticketService.reqByIssueType(fIssueType);
					req = reqByIssueType;
				}
			}
			if((fIssueCategory != null) && (fIssueCategory != "")) {
				if(fIssueCategory.contentEquals("none")) {
					fIssueCategory = null;
				}else {
					reqByIssueCategory = ticketService.reqByIssueCategory(fIssueCategory);
					req = reqByIssueCategory;
				}
			}
			if(((fIssueType != null) && (fIssueType != "")) && ((fIssueCategory != null) && (fIssueCategory != ""))) {
				reqByIssueType.retainAll(reqByIssueCategory);
				req = null;
				req = reqByIssueType;
			}				
		}else
			req = null;

		return req;
	}
	
	@RequestMapping("/support-filter")
	public ModelAndView filterSupport(@RequestParam(value = "filter", required = false) String filter,
			@RequestParam(value = "from_date", required = false)String fromDate,
			@RequestParam(value = "to_date", required = false)String toDate,	
			@RequestParam(value = "filter_status", required = false)String fStatus) throws ParseException {
		ModelAndView filterModel = new ModelAndView();
		SimpleDateFormat dateFor = new SimpleDateFormat("dd-MM-yyyy");
		List<Request > request = null;
		if(filter != "" && filter != null)
			request = listByFilter(filter, fromDate, toDate, fStatus, "", "", "");
		else
			request = ticketService.allrequests();
		System.out.println(filter);
		List<Object> issueDescription = new ArrayList<>();
		List<Object> issueId = new ArrayList<>();
		List<Object> status = new ArrayList<>();
		List<Object> customerId = new ArrayList<>();
		List<Object> customerName = new ArrayList<>();
		List<Object> createdDate = new ArrayList<>();
		List<Object> type = new ArrayList<>();
		List<Object> category = new ArrayList<>();
		
		for(int i = 0; i < request.size(); i++) {
			if(request.get(i).getUser() == userId) {
				issueDescription.add(request.get(i).getDesc());
				issueId.add(request.get(i).getId());
				createdDate.add(dateFor.format(request.get(i).getDate()));
				status.add(request.get(i).getStatus());
				customerId.add(request.get(i).getCid());
				type.add(request.get(i).getType());
				category.add(request.get(i).getCategory());
				User getName = ticketService.getUser(request.get(i).getCid());
				customerName.add(getName.getUsername());
			}
		}
		filterModel.addObject("desc", issueDescription);
		filterModel.addObject("rid", issueId);
		filterModel.addObject("type", type);
		filterModel.addObject("category", category);
		filterModel.addObject("custId", customerId);
		filterModel.addObject("custName", customerName);
		filterModel.addObject("sts", status);
		filterModel.addObject("dt", createdDate);
		filterModel.setViewName("support");
		return filterModel;
	}
	
}
