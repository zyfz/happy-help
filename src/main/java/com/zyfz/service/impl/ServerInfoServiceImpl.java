package com.zyfz.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyfz.dao.CommentMapper;
import com.zyfz.dao.ServerContractMapper;
import com.zyfz.dao.ServerInfoMapper;
import com.zyfz.domain.Comment;
import com.zyfz.domain.ServerContract;
import com.zyfz.domain.ServerInfo;
import com.zyfz.model.Datagrid;
import com.zyfz.model.PageModel;
import com.zyfz.service.ICommentService;
import com.zyfz.service.IServerInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ron on 16-11-1.
 */
@Service
public class ServerInfoServiceImpl implements IServerInfoService{
    @Resource
    ServerInfoMapper serverInfoMapper;

    @Resource
    CommentMapper commentMapper;

    @Resource
    ServerContractMapper serverContractMapper;

    @Override
    public Integer save(ServerInfo serverInfo) {
        serverInfo.setCreateTime(new Date());
        serverInfoMapper.insertSelective(serverInfo);
        return serverInfo.getId();
    }

    @Override
    public Integer update(ServerInfo serverInfo) {
        return serverInfoMapper.updateByPrimaryKeySelective(serverInfo);
    }

    @Override
    public Datagrid getServerInfoByCategoryId(Integer categoryId,PageModel pageModel) {
        PageHelper.startPage(pageModel.getPage(),pageModel.getRows());
        List<ServerInfo> serverInfos = serverInfoMapper.selectByCIDWithUser(categoryId);
        PageInfo pageInfo = new PageInfo(serverInfos);
        Datagrid datagrid = new Datagrid();
        datagrid.setRows(serverInfos);
        datagrid.setTotal(pageInfo.getTotal());
        return datagrid;
    }

    @Override
    public Datagrid getServerInfoByKey(String key, PageModel pageModel) {
        PageHelper.startPage(pageModel.getPage(),pageModel.getRows());
        String myKey = "%"+key+"%";
        List<ServerInfo> serverInfos = serverInfoMapper.selectByCIDWithUserWithKey(myKey);
        PageInfo pageInfo = new PageInfo(serverInfos);
        Datagrid datagrid = new Datagrid();
        datagrid.setRows(serverInfos);
        datagrid.setTotal(pageInfo.getTotal());
        return datagrid;
    }


    @Override
    public Datagrid getAll(PageModel pageModel) {
        return null;
    }

    @Override
    public ServerInfo getOneById(ServerInfo serverInfo) {
        return serverInfoMapper.selectByPrimaryKey(serverInfo.getId());
    }

    @Override
    public Integer deleteOneById(ServerInfo serverInfo) {
        List<Comment> comments = commentMapper.selectCommentWithUserByTypeId(serverInfo.getId(),"2");
        if(comments.size() != 0){
            for (Comment comment : comments){
                commentMapper.deleteByPrimaryKey(comment.getId());
            }
        }
        return serverInfoMapper.deleteByPrimaryKey(serverInfo.getId());
    }

    @Override
    public Datagrid get4App(ServerInfo serverInfo, PageModel pageModel) {
        PageHelper.startPage(pageModel.getPage(),pageModel.getRows());
        List<ServerInfo> serverInfos = serverInfoMapper.select4App(serverInfo);
        PageInfo pageInfo = new PageInfo(serverInfos);
        return new Datagrid(pageInfo.getTotal(),serverInfos);
    }

    @Override
    public Datagrid select4AppInMine(ServerContract serverContract, PageModel pageModel) {
        PageHelper.startPage(pageModel.getPage(),pageModel.getRows());
        List<ServerInfo> serverInfos = serverInfoMapper.select4AppInMine(serverContract);
        PageInfo pageInfo = new PageInfo(serverInfos);
        ServerContract serverContract1 = new ServerContract();
        List<ServerInfo> mServerInfos = new ArrayList<ServerInfo>();
        for (ServerInfo serverInfo : serverInfos){
            serverContract1 = new ServerContract();
            serverContract1.setHhUserId(serverContract.getHhUserId());
            serverContract1.setHhServerInfoId(serverInfo.getId());
            ServerContract serverContract2 = serverContractMapper.selectByUserAndServer(serverContract1);
            serverInfo.setServerContract(serverContract2);
            mServerInfos.add(serverInfo);
        }
        return new Datagrid(pageInfo.getTotal(),mServerInfos);
    }

    @Override
    public List<ServerInfo> selectByCategory(Integer cid) {
        return serverInfoMapper.selectByCategory(cid);
    }

    @Override
    public ServerInfo selectByUniq(Integer id) {
        ServerInfo serverInfo = serverInfoMapper.selectByPrimaryKey(id);
        List<ServerContract> serverContracts = serverContractMapper.selectByServerId(serverInfo.getId());
        serverInfo.setServerContracts(serverContracts);
        return serverInfo;
    }
}
