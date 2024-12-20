package edu.sm.controller;

import edu.sm.app.dto.GhtlfDto;
import edu.sm.app.dto.UsersDto;
import edu.sm.app.service.GhtlfService;
import edu.sm.app.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/users")
public class UsersController {

    final UsersService usersService;
    final GhtlfService ghtlfService;

    @RequestMapping("")
    public String notice(Model model) throws Exception {
        List<GhtlfDto> ghtlfList = ghtlfService.get();

        Map<Integer, List<GhtlfDto>> groupedByFloor = ghtlfList.stream()
                .collect(Collectors.groupingBy(item -> item.getRoom() / 100));

        List<Map.Entry<Integer, List<GhtlfDto>>> floors = groupedByFloor.entrySet().stream()
                .sorted((a, b) -> b.getKey().compareTo(a.getKey()))
                .collect(Collectors.toList());

        List<GhtlfDto> rentCalcList = ghtlfService.rentcalc();

        model.addAttribute("rentCalc", rentCalcList);
        model.addAttribute("ghtlf", floors);
        model.addAttribute("center", "users/users");


        return "index";
    }


    @RequestMapping("/detail")
    public String detail(Model model, @RequestParam("ghtlfid") Integer id) throws Exception {
        GhtlfDto ghtlfDto = null;
        ghtlfDto = ghtlfService.get(id);

        model.addAttribute("ghtlf", ghtlfDto);
        model.addAttribute("center", "users/detail");

        return "index";
    }

    @RequestMapping("/detailud")
    public String detail2(Model model, @RequestParam("ghtlfid") Integer id) throws Exception {
        GhtlfDto ghtlfDto = null;
        ghtlfDto = ghtlfService.get(id);

        model.addAttribute("ghtlf", ghtlfDto);
        model.addAttribute("center", "users/detailud");

        return "index";
    }

    @RequestMapping("/updateus")
    public String updateimpl(Model model, GhtlfDto ghtlfDto,
                             @RequestParam("bname") String bname,
                             @RequestParam("room") Integer room,
                             @RequestParam("dlfma") String dlfma,
                             @RequestParam("tel") String tel,
                             @RequestParam("ghtlfid") Integer ghtlfid) throws Exception {

        ghtlfDto.setBname(bname);
        ghtlfDto.setRoom(room);
        ghtlfDto.setDlfma(dlfma);
        ghtlfDto.setTel(tel);
        ghtlfDto.setGhtlfid(ghtlfid);

        ghtlfService.updateus(ghtlfDto);

        return "redirect:/users";
    }

    @RequestMapping("/updatect")
    public String updateContractInfo(Model model, GhtlfDto ghtlfDto,
                                     @RequestParam("stday") String stday,
                                     @RequestParam("edday") String edday,
                                     @RequestParam("deposit") Integer deposit,
                                     @RequestParam("dnjftp") Integer dnjftp,
                                     @RequestParam("ghtlfid") Integer ghtlfid) throws Exception {

        ghtlfDto.setStday(stday);
        ghtlfDto.setEdday(edday);
        ghtlfDto.setDeposit(deposit);
        ghtlfDto.setDnjftp(dnjftp);
        ghtlfDto.setGhtlfid(ghtlfid);

        ghtlfService.updatect(ghtlfDto);

        // 사용자 목록 페이지로 리다이렉트
        return "redirect:/users";
    }


    @RequestMapping("/deleteimpl")
    public String deleteimpl(Model model, UsersDto usersDto,
                             @RequestParam("userPwd") String userPwd,
                             @RequestParam("userTel") String userTel,
                             @RequestParam("userMail") String userMaiil,
                             @RequestParam("userName") String userName) throws Exception {

        usersDto.setUserPwd(userPwd);
        usersDto.setUserTel(userTel);
        usersDto.setUserMail(userMaiil);
        usersDto.setUserName(userName);

        usersService.modify(usersDto);

        return "redirect:/users";
    }


}
