git = require '../../lib/git'
{repo} = require '../fixtures'
MergeListView = require '../../lib/views/merge-list-view'

describe "MergeListView", ->
  beforeEach ->
    @view = new MergeListView(repo, "branch1\nbranch2")
    spyOn(git, 'cmd').andCallFake ->
      Promise.reject 'blah'

  it "displays a list of branches", ->
    expect(@view.items.length).toBe 2

  it "calls git.cmd with 'merge branch1' when branch1 is selected", ->
    @view.confirmSelection()
    waitsFor -> git.cmd.callCount > 0
    expect(git.cmd).toHaveBeenCalledWith ['merge', 'branch1'], cwd: repo.getWorkingDirectory()
