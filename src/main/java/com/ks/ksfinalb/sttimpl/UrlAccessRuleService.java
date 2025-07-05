package com.ks.ksfinalb.sttimpl;

import com.ks.ksfinalb.model.stt.UrlAccessRule;
import com.ks.ksfinalb.repository.UrlAccessRuleRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UrlAccessRuleService implements IUrlAccessRuleService {
    private final UrlAccessRuleRepository urlAccessRuleRepository;

    public UrlAccessRuleService(UrlAccessRuleRepository urlAccessRuleRepository) {
        this.urlAccessRuleRepository = urlAccessRuleRepository;
    }

    public List<UrlAccessRule> getAllRules() {
        List<UrlAccessRule> urlAccessRuleList = urlAccessRuleRepository.findAll();
        // Fetch from DB or config
        return urlAccessRuleList;
    }
}
