//
//  GithubReposityItem.swift
//  NetworkLib
//
//  Created by JateXu on 2020/6/3.
//  Copyright © 2020 JateXu IOS Team. All rights reserved.
//

import Foundation
import SwiftyJSON
import ProtocolLibrary

extension GithubReposityModel : SwiftJSONAble {
    convenience init?(json: JSON) {
        self.init()
        if json.isEmpty{
            return
        }
        incompleteResults = json["incomplete_results"].boolValue
        items = [GithubReposityItem]()
        let itemsArray = json["items"].arrayValue
        for itemsJson in itemsArray {
            if let value = GithubReposityItem(json: itemsJson) {
                items.append(value)
            }
        }
        totalCount = json["total_count"].intValue
    }
}

extension GithubReposityItem : SwiftJSONAble {
    convenience init?(json: JSON) {
        self.init()
        if json.isEmpty{
            return
        }
        archiveUrl = json["archive_url"].stringValue
        archived = json["archived"].boolValue
        assigneesUrl = json["assignees_url"].stringValue
        blobsUrl = json["blobs_url"].stringValue
        branchesUrl = json["branches_url"].stringValue
        cloneUrl = json["clone_url"].stringValue
        collaboratorsUrl = json["collaborators_url"].stringValue
        commentsUrl = json["comments_url"].stringValue
        commitsUrl = json["commits_url"].stringValue
        compareUrl = json["compare_url"].stringValue
        contentsUrl = json["contents_url"].stringValue
        contributorsUrl = json["contributors_url"].stringValue
        createdAt = json["created_at"].stringValue
        defaultBranch = json["default_branch"].stringValue
        deploymentsUrl = json["deployments_url"].stringValue
        descriptionField = json["description"].stringValue
        disabled = json["disabled"].boolValue
        downloadsUrl = json["downloads_url"].stringValue
        eventsUrl = json["events_url"].stringValue
        fork = json["fork"].boolValue
        forks = json["forks"].intValue
        forksCount = json["forks_count"].intValue
        forksUrl = json["forks_url"].stringValue
        fullName = json["full_name"].stringValue
        gitCommitsUrl = json["git_commits_url"].stringValue
        gitRefsUrl = json["git_refs_url"].stringValue
        gitTagsUrl = json["git_tags_url"].stringValue
        gitUrl = json["git_url"].stringValue
        hasDownloads = json["has_downloads"].boolValue
        hasIssues = json["has_issues"].boolValue
        hasPages = json["has_pages"].boolValue
        hasProjects = json["has_projects"].boolValue
        hasWiki = json["has_wiki"].boolValue
        homepage = json["homepage"].stringValue as AnyObject
        hooksUrl = json["hooks_url"].stringValue
        htmlUrl = json["html_url"].stringValue
        id = json["id"].intValue
        issueCommentUrl = json["issue_comment_url"].stringValue
        issueEventsUrl = json["issue_events_url"].stringValue
        issuesUrl = json["issues_url"].stringValue
        keysUrl = json["keys_url"].stringValue
        labelsUrl = json["labels_url"].stringValue
        language = json["language"].stringValue
        languagesUrl = json["languages_url"].stringValue
        let licenseJson = json["license"]
        if !licenseJson.isEmpty{
            license = GithubReposityLicense(json: licenseJson)
        }
        mergesUrl = json["merges_url"].stringValue
        milestonesUrl = json["milestones_url"].stringValue
        mirrorUrl = json["mirror_url"].stringValue as AnyObject
        name = json["name"].stringValue
        nodeId = json["node_id"].stringValue
        notificationsUrl = json["notifications_url"].stringValue
        openIssues = json["open_issues"].intValue
        openIssuesCount = json["open_issues_count"].intValue
        let ownerJson = json["owner"]
        if !ownerJson.isEmpty{
            owner = GithubReposityOwner(json: ownerJson)
        }
        privateField = json["private"].boolValue
        pullsUrl = json["pulls_url"].stringValue
        pushedAt = json["pushed_at"].stringValue
        releasesUrl = json["releases_url"].stringValue
        score = json["score"].floatValue
        size = json["size"].intValue
        sshUrl = json["ssh_url"].stringValue
        stargazersCount = json["stargazers_count"].intValue
        stargazersUrl = json["stargazers_url"].stringValue
        statusesUrl = json["statuses_url"].stringValue
        subscribersUrl = json["subscribers_url"].stringValue
        subscriptionUrl = json["subscription_url"].stringValue
        svnUrl = json["svn_url"].stringValue
        tagsUrl = json["tags_url"].stringValue
        teamsUrl = json["teams_url"].stringValue
        treesUrl = json["trees_url"].stringValue
        updatedAt = json["updated_at"].stringValue
        url = json["url"].stringValue
        watchers = json["watchers"].intValue
        watchersCount = json["watchers_count"].intValue
    }
}

extension GithubReposityLicense : SwiftJSONAble {
    convenience init?(json: JSON) {
        self.init()
        if json.isEmpty{
            return
        }
        key = json["key"].stringValue
        name = json["name"].stringValue
        nodeId = json["node_id"].stringValue
        spdxId = json["spdx_id"].stringValue
        url = json["url"].stringValue
    }
}

extension GithubReposityOwner : SwiftJSONAble {
    convenience init?(json: JSON) {
        self.init()
        if json.isEmpty {
            return nil
        }
        avatarUrl = json["avatar_url"].stringValue
        eventsUrl = json["events_url"].stringValue
        followersUrl = json["followers_url"].stringValue
        followingUrl = json["following_url"].stringValue
        gistsUrl = json["gists_url"].stringValue
        gravatarId = json["gravatar_id"].stringValue
        htmlUrl = json["html_url"].stringValue
        id = json["id"].intValue
        login = json["login"].stringValue
        nodeId = json["node_id"].stringValue
        organizationsUrl = json["organizations_url"].stringValue
        receivedEventsUrl = json["received_events_url"].stringValue
        reposUrl = json["repos_url"].stringValue
        siteAdmin = json["site_admin"].boolValue
        starredUrl = json["starred_url"].stringValue
        subscriptionsUrl = json["subscriptions_url"].stringValue
        type = json["type"].stringValue
        url = json["url"].stringValue
    }
}
