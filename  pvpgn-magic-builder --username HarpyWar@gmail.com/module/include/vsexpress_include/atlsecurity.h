// This is a part of the Active Template Library.
// Copyright (C) Microsoft Corporation
// All rights reserved.
//
// This source code is only intended as a supplement to the
// Active Template Library Reference and related
// electronic documentation provided with the library.
// See these sources for detailed information regarding the
// Active Template Library product.
#ifndef __ATLSECURITY_H__
#define __ATLSECURITY_H__

#pragma once

#include <sddl.h>
#include <userenv.h>
#include <aclapi.h>
#include <atlcoll.h>
#include <atlstr.h>

#pragma warning(push)
#pragma warning(disable: 4625) // copy constructor could not be generated because a base class copy constructor is inaccessible
#pragma warning(disable: 4626) // assignment operator could not be generated because a base class assignment operator is inaccessible
#pragma warning(disable: 4571) //catch(...) blocks compiled with /EHs do NOT catch or re-throw Structured Exceptions
#ifndef _CPPUNWIND
#pragma warning (disable : 4702)	// unreachable code
#endif


#pragma pack(push,_ATL_PACKING)
namespace ATL
{
#pragma comment(lib, "userenv.lib")

// **************************************************************
// CSid

class CSid
{

public:
	CSid() throw();

	explicit CSid(
		_In_z_ LPCTSTR pszAccountName,
		_In_opt_z_ LPCTSTR pszSystem = NULL) throw(...);
	explicit CSid(
		_In_ const SID *pSid,
		_In_opt_z_ LPCTSTR pszSystem = NULL) throw(...);
	CSid(
		_In_ const SID_IDENTIFIER_AUTHORITY &IdentifierAuthority,
		_In_ BYTE nSubAuthorityCount, ...) throw(...);
	virtual ~CSid() throw();

	CSid(_In_ const CSid &rhs) throw(...);
	CSid &operator=(_In_ const CSid &rhs) throw(...);

	CSid(_In_ const SID &rhs) throw(...);
	CSid &operator=(_In_ const SID &rhs) throw(...);

	typedef CAtlArray<CSid> CSidArray;

	bool LoadAccount(
		_In_z_ LPCTSTR pszAccountName,
		_In_opt_z_ LPCTSTR pszSystem = NULL) throw(...);
	bool LoadAccount(
		_In_ const SID *pSid,
		_In_opt_z_ LPCTSTR pszSystem = NULL) throw(...);

	LPCTSTR AccountName() const throw(...);
	LPCTSTR Domain() const throw(...);
	LPCTSTR Sid() const throw(...);

	const SID *GetPSID() const throw(...);
	operator const SID *() const throw(...);
	SID_NAME_USE SidNameUse() const throw();

	UINT GetLength() const throw();

	// SID functions
	bool EqualPrefix(_In_ const CSid &rhs) const throw();
	bool EqualPrefix(_In_ const SID &rhs) const throw();

	const SID_IDENTIFIER_AUTHORITY *GetPSID_IDENTIFIER_AUTHORITY() const throw();
	DWORD GetSubAuthority(_In_ DWORD nSubAuthority) const throw();
	UCHAR GetSubAuthorityCount() const throw();
	bool IsValid() const throw();

private:
	void Copy(_In_ const SID &rhs) throw(...);
	void Clear() throw();
	void GetAccountNameAndDomain() const throw(...);
	SID* _GetPSID() const throw();

	BYTE m_buffer[SECURITY_MAX_SID_SIZE];
	bool m_bValid; // true if the CSid has been given a value

	mutable SID_NAME_USE m_sidnameuse;
	mutable CString m_strAccountName;
	mutable CString m_strDomain;
	mutable CString m_strSid;

	CString m_strSystem;
};

bool operator==(
	_In_ const CSid &lhs,
	_In_ const CSid &rhs) throw();
bool operator!=(
	_In_ const CSid &lhs,
	_In_ const CSid &rhs) throw();

// sort operations are provided to allow CSids to be put into
// sorted stl collections (stl::[multi]map, stl::[multi]set)
bool operator<(
	_In_ const CSid &lhs,
	_In_ const CSid &rhs) throw();
bool operator>(
	_In_ const CSid &lhs,
	_In_ const CSid &rhs) throw();
bool operator<=(
	_In_ const CSid &lhs,
	_In_ const CSid &rhs) throw();
bool operator>=(
	_In_ const CSid &lhs,
	_In_ const CSid &rhs) throw();

// **************************************************************
// Well-known sids

namespace Sids
{
// Universal
CSid Null() throw(...);
CSid World() throw(...);
CSid Local() throw(...);
CSid CreatorOwner() throw(...);
CSid CreatorGroup() throw(...);
CSid CreatorOwnerServer() throw(...);
CSid CreatorGroupServer() throw(...);

// NT Authority
CSid Dialup() throw(...);
CSid Network() throw(...);
CSid Batch() throw(...);
CSid Interactive() throw(...);
CSid Service() throw(...);
CSid AnonymousLogon() throw(...);
CSid Proxy() throw(...);
CSid ServerLogon() throw(...);
CSid Self() throw(...);
CSid AuthenticatedUser() throw(...);
CSid RestrictedCode() throw(...);
CSid TerminalServer() throw(...);
CSid System() throw(...);
CSid NetworkService() throw (...);

// NT Authority\BUILTIN
CSid Admins() throw(...);
CSid Users() throw(...);
CSid Guests() throw(...);
CSid PowerUsers() throw(...);
CSid AccountOps() throw(...);
CSid SystemOps() throw(...);
CSid PrintOps() throw(...);
CSid BackupOps() throw(...);
CSid Replicator() throw(...);
CSid RasServers() throw(...);
CSid PreW2KAccess() throw(...);
} // namespace Sids

//***************************************
// CAcl
//		CAce
//
//		CDacl
//			CAccessAce
//
//		CSacl
//			CAuditAce
//***************************************

// **************************************************************
// CAcl

class CAcl
{
public:
	CAcl() throw();
	virtual ~CAcl() throw();

	CAcl(_In_ const CAcl &rhs) throw(...);
	CAcl &operator=(_In_ const CAcl &rhs) throw(...);

	typedef CAtlArray<ACCESS_MASK> CAccessMaskArray;
	typedef CAtlArray<BYTE> CAceTypeArray;
	typedef CAtlArray<BYTE> CAceFlagArray;

	void GetAclEntries(
		_Out_ CSid::CSidArray *pSids,
		_Out_opt_ CAccessMaskArray *pAccessMasks = NULL,
		_Out_opt_ CAceTypeArray *pAceTypes = NULL,
		_Out_opt_ CAceFlagArray *pAceFlags = NULL) const throw(...);
	void GetAclEntry(
		_In_ UINT nIndex,
		_Inout_opt_ CSid* pSid,
		_Out_opt_ ACCESS_MASK* pMask = NULL,
		_Out_opt_ BYTE* pType = NULL,
		_Out_opt_ BYTE* pFlags = NULL,
		_Out_opt_ GUID* pObjectType = NULL,
		_Out_opt_ GUID* pInheritedObjectType = NULL) const throw(...);

	bool RemoveAces(_In_ const CSid &rSid) throw(...);

	virtual UINT GetAceCount() const throw() = 0;
	virtual void RemoveAllAces() throw() = 0;
	virtual void RemoveAce(_In_ UINT nIndex) = 0;

	const ACL *GetPACL() const throw(...);
	operator const ACL *() const throw(...);
	UINT GetLength() const throw(...);

	void SetNull() throw();
	void SetEmpty() throw();
	bool IsNull() const throw();
	bool IsEmpty() const throw();

private:
	mutable ACL *m_pAcl;
	bool m_bNull;

protected:
	void Dirty() throw();

	class CAce
	{
	public:
		CAce(
			_In_ const CSid &rSid,
			_In_ ACCESS_MASK accessmask,
			_In_ BYTE aceflags) throw(...);
		virtual ~CAce() throw();

		CAce(_In_ const CAce &rhs) throw(...);
		CAce &operator=(_In_ const CAce &rhs) throw(...);

		virtual void *GetACE() const throw(...) = 0;
		virtual UINT GetLength() const throw() = 0;
		virtual BYTE AceType() const throw() = 0;
		virtual bool IsObjectAce() const throw();
		virtual GUID ObjectType() const throw();
		virtual GUID InheritedObjectType() const throw();

		ACCESS_MASK AccessMask() const throw();
		BYTE AceFlags() const throw();
		const CSid &Sid() const throw();

		void AddAccess(_In_ ACCESS_MASK accessmask) throw();

	protected:
		CSid m_sid;
		ACCESS_MASK m_dwAccessMask;
		BYTE m_aceflags;
		mutable void *m_pAce;
	};

	virtual const CAce *GetAce(_In_ UINT nIndex) const = 0;
	virtual void PrepareAcesForACL() const throw();

	DWORD m_dwAclRevision;
};

// ************************************************
// CDacl

class CDacl :
	public CAcl
{
public:
	CDacl() throw();
	virtual ~CDacl() throw();

	CDacl(_In_ const CDacl &rhs) throw(...);
	CDacl &operator=(_In_ const CDacl &rhs) throw(...);

	CDacl(_In_ const ACL &rhs) throw(...);
	CDacl &operator=(_In_ const ACL &rhs) throw(...);

	bool AddAllowedAce(
		_In_ const CSid &rSid,
		_In_ ACCESS_MASK accessmask,
		_In_ BYTE aceflags = 0) throw(...);
	bool AddDeniedAce(
		_In_ const CSid &rSid,
		_In_ ACCESS_MASK accessmask,
		_In_ BYTE aceflags = 0) throw(...);
#if(_WIN32_WINNT >= 0x0500)
	bool AddAllowedAce(
		_In_ const CSid &rSid,
		_In_ ACCESS_MASK accessmask,
		_In_ BYTE aceflags,
		_In_ const GUID *pObjectType,
		_In_ const GUID *pInheritedObjectType) throw(...);
	bool AddDeniedAce(
		_In_ const CSid &rSid,
		_In_ ACCESS_MASK accessmask,
		_In_ BYTE aceflags,
		_In_ const GUID *pObjectType,
		_In_ const GUID *pInheritedObjectType) throw(...);
#endif
	void RemoveAllAces() throw();
	void RemoveAce(_In_ UINT nIndex);

	UINT GetAceCount() const throw();

private:
	void Copy(_In_ const CDacl &rhs) throw(...);
	void Copy(_In_ const ACL &rhs) throw(...);

	class CAccessAce : 
		public CAcl::CAce
	{
	public:
		CAccessAce(
			_In_ const CSid &rSid,
			_In_ ACCESS_MASK accessmask,
			_In_ BYTE aceflags,
			_In_ bool bAllowAccess) throw(...);
		virtual ~CAccessAce() throw();

		void *GetACE() const throw(...);
		UINT GetLength() const throw();
		BYTE AceType() const throw();

		bool Allow() const throw();
		bool Inherited() const throw();

		static int Order(
			_In_ const CAccessAce &lhs,
			_In_ const CAccessAce &rhs) throw();

	protected:
		bool m_bAllow;
	};

#if(_WIN32_WINNT >= 0x0500)
	class CAccessObjectAce : 
		public CAccessAce
	{
	public:
		CAccessObjectAce(
			_In_ const CSid &rSid,
			_In_ ACCESS_MASK accessmask,
			_In_ BYTE aceflags,
			_In_ bool bAllowAccess,
			_In_opt_ const GUID *pObjectType,
			_In_opt_ const GUID *pInheritedObjectType) throw(...);
		virtual ~CAccessObjectAce() throw();

		CAccessObjectAce(_In_ const CAccessObjectAce &rhs) throw(...);
		CAccessObjectAce &operator=(_In_ const CAccessObjectAce &rhs) throw(...);

		void *GetACE() const throw(...);
		UINT GetLength() const throw();
		BYTE AceType() const throw();
		bool IsObjectAce() const throw();
		virtual GUID ObjectType() const throw();
		virtual GUID InheritedObjectType() const throw();

	protected:
		GUID *m_pObjectType;
		GUID *m_pInheritedObjectType;
	};

#endif
	const CAcl::CAce *GetAce(_In_ UINT nIndex) const;

	void PrepareAcesForACL() const throw();

	mutable CAutoPtrArray<CAccessAce> m_acl;
};

//******************************************
// CSacl

class CSacl : 
	public CAcl
{
public:
	CSacl() throw();
	virtual ~CSacl() throw();

	CSacl(_In_ const CSacl &rhs) throw(...);
	CSacl &operator=(_In_ const CSacl &rhs) throw(...);

	CSacl(_In_ const ACL &rhs) throw(...);
	CSacl &operator=(_In_ const ACL &rhs) throw(...);

	bool AddAuditAce(
		_In_ const CSid &rSid,
		_In_ ACCESS_MASK accessmask,
		_In_ bool bSuccess,
		_In_ bool bFailure,
		_In_ BYTE aceflags = 0) throw(...);
#if(_WIN32_WINNT >= 0x0500)
	bool AddAuditAce(
		_In_ const CSid &rSid,
		_In_ ACCESS_MASK accessmask,
		_In_ bool bSuccess,
		_In_ bool bFailure,
		_In_ BYTE aceflags,
		_In_ const GUID *pObjectType,
		_In_ const GUID *pInheritedObjectType) throw(...);
#endif
	void RemoveAllAces() throw();
	void RemoveAce(_In_ UINT nIndex);

	UINT GetAceCount() const throw();

private:
	void Copy(_In_ const CSacl &rhs) throw(...);
	void Copy(_In_ const ACL &rhs) throw(...);

	class CAuditAce : 
		public CAcl::CAce
	{
	public:
		CAuditAce(
			_In_ const CSid &rSid,
			_In_ ACCESS_MASK accessmask,
			_In_ BYTE aceflags,
			_In_ bool bAuditSuccess,
			_In_ bool bAuditFailure) throw(...);
		virtual ~CAuditAce() throw();

		void *GetACE() const throw(...);
		UINT GetLength() const throw();
		BYTE AceType() const throw();
	protected:
		bool m_bSuccess;
		bool m_bFailure;
	};

#if(_WIN32_WINNT >= 0x0500)
	class CAuditObjectAce :
		public CAuditAce
	{
	public:
		CAuditObjectAce(
			_In_ const CSid &rSid,
			_In_ ACCESS_MASK accessmask,
			_In_ BYTE aceflags,
			_In_ bool bAuditSuccess,
			_In_ bool bAuditFailure,
			_In_opt_ const GUID *pObjectType,
			_In_opt_ const GUID *pInheritedObjectType) throw(...);
		virtual ~CAuditObjectAce() throw();

		CAuditObjectAce(_In_ const CAuditObjectAce &rhs) throw(...);
		CAuditObjectAce &operator=(_In_ const CAuditObjectAce &rhs) throw(...);

		void *GetACE() const throw(...);
		UINT GetLength() const throw();
		BYTE AceType() const throw();
		bool IsObjectAce() const throw();
		virtual GUID ObjectType() const throw();
		virtual GUID InheritedObjectType() const throw();

	protected:
		GUID *m_pObjectType;
		GUID *m_pInheritedObjectType;
	};
#endif
	const CAce *GetAce(_In_ UINT nIndex) const;

	CAutoPtrArray<CAuditAce> m_acl;
};

//******************************************
// CSecurityDesc

class CSecurityDesc
{
public:
	CSecurityDesc() throw();
	virtual ~CSecurityDesc() throw();

	CSecurityDesc(_In_ const CSecurityDesc &rhs) throw(...);
	CSecurityDesc &operator=(_In_ const CSecurityDesc &rhs) throw(...);

	CSecurityDesc(_In_ const SECURITY_DESCRIPTOR &rhs) throw(...);
	CSecurityDesc &operator=(_In_ const SECURITY_DESCRIPTOR &rhs) throw(...);

#if(_WIN32_WINNT >= 0x0500)
	bool FromString(_In_z_ LPCTSTR pstr) throw(...);
	bool ToString(
		_In_ CString *pstr,
		_In_ SECURITY_INFORMATION si =
			OWNER_SECURITY_INFORMATION |
			GROUP_SECURITY_INFORMATION |
			DACL_SECURITY_INFORMATION |
			SACL_SECURITY_INFORMATION) const throw(...);
#endif

	void SetOwner(
		_In_ const CSid &sid,
		_In_ bool bDefaulted = false) throw(...);
	void SetGroup(
		_In_ const CSid &sid,
		_In_ bool bDefaulted = false) throw(...);
	void SetDacl(
		_In_ const CDacl &Dacl,
		_In_ bool bDefaulted = false) throw(...);
	void SetDacl(
		_In_ bool bPresent,
		_In_ bool bDefaulted = false) throw(...);
	void SetSacl(
		_In_ const CSacl &Sacl,
		_In_ bool bDefaulted = false) throw(...);
	bool GetOwner(
		_Out_ CSid *pSid,
		_Out_opt_ bool *pbDefaulted = NULL) const throw(...);
	bool GetGroup(
		_Out_ CSid *pSid,
		_Out_opt_ bool *pbDefaulted = NULL) const throw(...);
	bool GetDacl(
		_Out_ CDacl *pDacl,
		_Out_opt_ bool *pbPresent = NULL,
		_Out_opt_ bool *pbDefaulted = NULL) const throw(...);
	bool GetSacl(
		_Out_ CSacl *pSacl,
		_Out_opt_ bool *pbPresent = NULL,
		_Out_opt_ bool *pbDefaulted = NULL) const throw(...);

	bool IsDaclDefaulted() const throw();
	bool IsDaclPresent() const throw();
	bool IsGroupDefaulted() const throw();
	bool IsOwnerDefaulted() const throw();
	bool IsSaclDefaulted() const throw();
	bool IsSaclPresent() const throw();
	bool IsSelfRelative() const throw();

	// Only meaningful on Win2k or better
	bool IsDaclAutoInherited() const throw();
	bool IsDaclProtected() const throw();
	bool IsSaclAutoInherited() const throw();
	bool IsSaclProtected() const throw();

	const SECURITY_DESCRIPTOR *GetPSECURITY_DESCRIPTOR() const throw();
	operator const SECURITY_DESCRIPTOR *() const throw();

	void GetSECURITY_DESCRIPTOR(
		_Out_ SECURITY_DESCRIPTOR *pSD,
		_Inout_ LPDWORD lpdwBufferLength) throw(...);

	UINT GetLength() throw();

	bool GetControl(_Out_ SECURITY_DESCRIPTOR_CONTROL *psdc) const throw();
#if(_WIN32_WINNT >= 0x0500)
	bool SetControl(
		_In_ SECURITY_DESCRIPTOR_CONTROL ControlBitsOfInterest,
		_In_ SECURITY_DESCRIPTOR_CONTROL ControlBitsToSet) throw();
#endif

	void MakeSelfRelative() throw(...);
	void MakeAbsolute() throw(...);

protected:
	virtual void Clear() throw();
	void AllocateAndInitializeSecurityDescriptor() throw(...);
	void Init(_In_ const SECURITY_DESCRIPTOR &rhs) throw(...);

	SECURITY_DESCRIPTOR *m_pSecurityDescriptor;
};

// **************************************************************
// CSecurityAttributes

class CSecurityAttributes :
	public SECURITY_ATTRIBUTES
{
public:
	CSecurityAttributes() throw();
	explicit CSecurityAttributes(
		_In_ const CSecurityDesc &rSecurityDescriptor,
		_In_ bool bInheritHandle = false) throw(...);

	void Set(
		_In_ const CSecurityDesc &rSecurityDescriptor,
		_In_ bool bInheritHandle = false) throw(...);

protected:
	CSecurityDesc m_SecurityDescriptor;
};

template<>
class CElementTraits< LUID > :
	public CElementTraitsBase< LUID >
{
public:
	typedef const LUID& INARGTYPE;
	typedef LUID& OUTARGTYPE;

	static ULONG Hash(_In_ INARGTYPE luid) throw()
	{
		return luid.HighPart ^ luid.LowPart;
	}

	static BOOL CompareElements(
		_In_ INARGTYPE element1,
		_In_ INARGTYPE element2) throw()
	{
		return element1.HighPart == element2.HighPart && element1.LowPart == element2.LowPart;
	}

	static int CompareElementsOrdered(
		_In_ INARGTYPE element1,
		_In_ INARGTYPE element2 ) throw()
	{
		_LARGE_INTEGER li1, li2;
		li1.LowPart = element1.LowPart;
		li1.HighPart = element1.HighPart;
		li2.LowPart = element2.LowPart;
		li2.HighPart = element2.HighPart;

		if( li1.QuadPart > li2.QuadPart )
			return( 1 );
		else if( li1.QuadPart < li2.QuadPart )
			return( -1 );

		return( 0 );
	}
};

typedef CAtlArray<LUID> CLUIDArray;

//******************************************************
// CTokenPrivileges

class CTokenPrivileges
{
public:
	CTokenPrivileges() throw();
	virtual ~CTokenPrivileges() throw();

	CTokenPrivileges(_In_ const CTokenPrivileges &rhs) throw(...);
	CTokenPrivileges &operator=(_In_ const CTokenPrivileges &rhs) throw(...);

	CTokenPrivileges(_In_ const TOKEN_PRIVILEGES &rPrivileges) throw(...);
	CTokenPrivileges &operator=(_In_ const TOKEN_PRIVILEGES &rPrivileges) throw(...);

	void Add(_In_ const TOKEN_PRIVILEGES &rPrivileges) throw(...);
	bool Add(
		_In_z_ LPCTSTR pszPrivilege,
		_In_ bool bEnable) throw(...);

	typedef CAtlArray<CString> CNames;
	typedef CAtlArray<DWORD> CAttributes;

	bool LookupPrivilege(
		_In_z_ LPCTSTR pszPrivilege,
		_Out_opt_ DWORD *pdwAttributes = NULL) const throw(...);
	void GetNamesAndAttributes(
		_Inout_ CNames *pNames,
		_Inout_opt_ CAttributes *pAttributes = NULL) const throw(...);
	void GetDisplayNames(_Inout_ CNames *pDisplayNames) const throw(...);
	void GetLuidsAndAttributes(
		_Inout_ CLUIDArray *pPrivileges,
		_Inout_opt_ CAttributes *pAttributes = NULL) const throw(...);

	bool Delete(_In_z_ LPCTSTR pszPrivilege) throw();
	void DeleteAll() throw();

	UINT GetCount() const throw();
	UINT GetLength() const throw();

	const TOKEN_PRIVILEGES *GetPTOKEN_PRIVILEGES() const throw(...);
	operator const TOKEN_PRIVILEGES *() const throw(...);

private:
	typedef CAtlMap<LUID, DWORD> Map;
	Map m_mapTokenPrivileges;
	mutable TOKEN_PRIVILEGES *m_pTokenPrivileges;
	bool m_bDirty;

	void AddPrivileges(_In_ const TOKEN_PRIVILEGES &rPrivileges) throw(...);
};

//******************************************************
// CTokenGroups

class CTokenGroups
{
public:
	CTokenGroups() throw();
	virtual ~CTokenGroups() throw();

	CTokenGroups(_In_ const CTokenGroups &rhs) throw(...);
	CTokenGroups &operator=(_In_ const CTokenGroups &rhs) throw(...);

	CTokenGroups(_In_ const TOKEN_GROUPS &rhs) throw(...);
	CTokenGroups &operator=(_In_ const TOKEN_GROUPS &rhs) throw(...);

	void Add(_In_ const TOKEN_GROUPS &rTokenGroups) throw(...);
	void Add(_In_ const CSid &rSid, _In_ DWORD dwAttributes) throw(...);

	bool LookupSid(
		_In_ const CSid &rSid,
		_Out_opt_ DWORD *pdwAttributes = NULL) const throw();
	void GetSidsAndAttributes(
		_Inout_ CSid::CSidArray *pSids,
		_Inout_opt_ CAtlArray<DWORD> *pAttributes = NULL) const throw(...);

	bool Delete(_In_ const CSid &rSid) throw();
	void DeleteAll() throw();

	UINT GetCount() const throw();
	UINT GetLength() const throw();

	const TOKEN_GROUPS *GetPTOKEN_GROUPS() const throw(...);
	operator const TOKEN_GROUPS *() const throw(...);

private:
	class CTGElementTraits :
		public CElementTraitsBase< CSid >
	{
	public:
		static UINT Hash(_In_ const CSid &sid) throw()
		{
			return sid.GetSubAuthority(sid.GetSubAuthorityCount() - 1);
		}

		static bool CompareElements(
			_In_ INARGTYPE element1,
			_In_ INARGTYPE element2 ) throw()
		{
			return( element1 == element2 );
		}
	};

	typedef CAtlMap<CSid, DWORD, CTGElementTraits> Map;
	Map m_mapTokenGroups;
	mutable TOKEN_GROUPS *m_pTokenGroups;
	mutable bool m_bDirty;

	void AddTokenGroups(_In_ const TOKEN_GROUPS &rTokenGroups) throw(...);
};

// *************************************
// CAccessToken

class CAccessToken
{
public:
	CAccessToken() throw();
	virtual ~CAccessToken() throw();

	void Attach(_In_ HANDLE hToken) throw();
	HANDLE Detach() throw();
	HANDLE GetHandle() const throw();
	HKEY HKeyCurrentUser() const throw();

	// Privileges
	bool EnablePrivilege(
		_In_z_ LPCTSTR pszPrivilege,
		_In_opt_ CTokenPrivileges *pPreviousState = NULL,
		_Out_opt_ bool* pbErrNotAllAssigned=NULL) throw(...);
	bool EnablePrivileges(
		_In_ const CAtlArray<LPCTSTR> &rPrivileges,
		_Inout_opt_ CTokenPrivileges *pPreviousState = NULL,
		_Out_opt_ bool* pbErrNotAllAssigned=NULL) throw(...);
	bool DisablePrivilege(
		_In_z_ LPCTSTR pszPrivilege,
		_In_opt_ CTokenPrivileges *pPreviousState = NULL,
		_Out_opt_ bool* pbErrNotAllAssigned=NULL) throw(...);
	bool DisablePrivileges(
		_In_ const CAtlArray<LPCTSTR> &rPrivileges,
		_Inout_opt_ CTokenPrivileges *pPreviousState = NULL,
		_Out_opt_ bool* pbErrNotAllAssigned=NULL) throw(...);
	bool EnableDisablePrivileges(
		_In_ const CTokenPrivileges &rPrivilenges,
		_Inout_opt_ CTokenPrivileges *pPreviousState = NULL,
		_Out_opt_ bool* pbErrNotAllAssigned=NULL) throw(...);
	bool PrivilegeCheck(
		_In_ PPRIVILEGE_SET RequiredPrivileges,
		_Out_ bool *pbResult) const throw();

	bool GetLogonSid(_Inout_ CSid *pSid) const throw(...);
	bool GetTokenId(_Out_ LUID *pluid) const throw(...);
	bool GetLogonSessionId(_Out_ LUID *pluid) const throw(...);

	bool CheckTokenMembership(
		_In_ const CSid &rSid,
		_Inout_ bool *pbIsMember) const throw(...);
#if(_WIN32_WINNT >= 0x0500)
	bool IsTokenRestricted() const throw();
#endif

	// Token Information
protected:
	void InfoTypeToRetType(
		_Inout_ CSid *pRet,
		_In_ const TOKEN_USER &rWork) const throw(...)
	{
		ATLENSURE(pRet);
		*pRet = *static_cast<SID *>(rWork.User.Sid);
	}

	void InfoTypeToRetType(
		_Inout_ CTokenGroups *pRet,
		_In_ const TOKEN_GROUPS &rWork) const throw(...)
	{
		ATLENSURE(pRet);
		*pRet = rWork;
	}

	void InfoTypeToRetType(
		_Inout_ CTokenPrivileges *pRet,
		_In_ const TOKEN_PRIVILEGES &rWork) const throw(...)
	{
		ATLENSURE(pRet);
		*pRet = rWork;
	}

	void InfoTypeToRetType(
		_Inout_ CSid *pRet,
		_In_ const TOKEN_OWNER &rWork) const throw(...)
	{
		ATLENSURE(pRet);
		*pRet = *static_cast<SID *>(rWork.Owner);
	}

	void InfoTypeToRetType(
		_Inout_ CSid *pRet,
		_In_ const TOKEN_PRIMARY_GROUP &rWork) const throw(...)
	{
		ATLENSURE(pRet);
		*pRet = *static_cast<SID *>(rWork.PrimaryGroup);
	}

	void InfoTypeToRetType(
		_Inout_ CDacl *pRet,
		_In_ const TOKEN_DEFAULT_DACL &rWork) const throw(...)
	{
		ATLENSURE(pRet);
		*pRet = *rWork.DefaultDacl;
	}

	template<typename RET_T, typename INFO_T>
	bool GetInfoConvert(
		_Inout_ RET_T *pRet,
		_In_ TOKEN_INFORMATION_CLASS TokenClass,
		_Out_opt_ INFO_T *pWork = NULL) const throw(...)
	{
		ATLASSERT(pRet);
		if(!pRet)
			return false;

		DWORD dwLen;
		::GetTokenInformation(m_hToken, TokenClass, NULL, 0, &dwLen);
		if(::GetLastError() != ERROR_INSUFFICIENT_BUFFER)
			return false;

		USES_ATL_SAFE_ALLOCA;
		pWork = static_cast<INFO_T *>(_ATL_SAFE_ALLOCA(dwLen, _ATL_SAFE_ALLOCA_DEF_THRESHOLD));
		if (pWork == NULL)
			return false;
		if(!::GetTokenInformation(m_hToken, TokenClass, pWork, dwLen, &dwLen))
			return false;

		InfoTypeToRetType(pRet, *pWork);
		return true;
	}

	template<typename RET_T>
	bool GetInfo(
		_Inout_ RET_T *pRet,
		_In_ TOKEN_INFORMATION_CLASS TokenClass) const throw(...)
	{
		ATLASSERT(pRet);
		if(!pRet)
			return false;

		DWORD dwLen;
		if(!::GetTokenInformation(m_hToken, TokenClass, pRet, sizeof(RET_T), &dwLen))
			return false;
		return true;
	}

public:
	bool GetDefaultDacl(_Inout_ CDacl *pDacl) const throw(...);
	bool GetGroups(_Inout_ CTokenGroups *pGroups) const throw(...);
	bool GetImpersonationLevel(_Inout_ SECURITY_IMPERSONATION_LEVEL *pImpersonationLevel) const throw(...);
	bool GetOwner(_Inout_ CSid *pSid) const throw(...);
	bool GetPrimaryGroup(_Inout_ CSid *pSid) const throw(...);
	bool GetPrivileges(_Inout_ CTokenPrivileges *pPrivileges) const throw(...);
	bool GetTerminalServicesSessionId(_Inout_ DWORD *pdwSessionId) const throw(...);
	bool GetSource(_Inout_ TOKEN_SOURCE *pSource) const throw(...);
	bool GetStatistics(_Inout_ TOKEN_STATISTICS *pStatistics) const throw(...);
	bool GetType(_Inout_ TOKEN_TYPE *pType) const throw(...);
	bool GetUser(_Inout_ CSid *pSid) const throw(...);

	bool SetOwner(_In_ const CSid &rSid) throw(...);
	bool SetPrimaryGroup(_In_ const CSid &rSid) throw(...);
	bool SetDefaultDacl(_In_ const CDacl &rDacl) throw(...);

	bool CreateImpersonationToken(
		_Inout_ CAccessToken *pImp,
		_In_ SECURITY_IMPERSONATION_LEVEL sil = SecurityImpersonation) const throw(...);
	bool CreatePrimaryToken(
		_Inout_ CAccessToken *pPri,
		_In_ DWORD dwDesiredAccess = MAXIMUM_ALLOWED,
		_In_opt_ const CSecurityAttributes *pTokenAttributes = NULL) const throw(...);

#if(_WIN32_WINNT >= 0x0500)
	bool CreateRestrictedToken(
		_Inout_ CAccessToken *pRestrictedToken,
		_In_ const CTokenGroups &SidsToDisable,
		_In_ const CTokenGroups &SidsToRestrict,
		_In_ const CTokenPrivileges &PrivilegesToDelete = CTokenPrivileges()) const throw(...);
#endif

	// Token API type functions
	bool GetProcessToken(
		_In_ DWORD dwDesiredAccess,
		_In_opt_ HANDLE hProcess = NULL) throw();
	bool GetThreadToken(
		_In_ DWORD dwDesiredAccess,
		_In_opt_ HANDLE hThread = NULL,
		_In_ bool bOpenAsSelf = true) throw();
	bool GetEffectiveToken(_In_ DWORD dwDesiredAccess) throw();

	bool OpenThreadToken(
		_In_ DWORD dwDesiredAccess,
		_In_ bool bImpersonate = false,
		_In_ bool bOpenAsSelf = true,
		_In_ SECURITY_IMPERSONATION_LEVEL sil = SecurityImpersonation) throw(...);

#if (_WIN32_WINNT >= 0x0400 ) || defined(_WIN32_DCOM)
	bool OpenCOMClientToken(
		_In_ DWORD dwDesiredAccess,
		_In_ bool bImpersonate = false,
		_In_ bool bOpenAsSelf = true) throw(...);
#endif //(_WIN32_WINNT >= 0x0400 ) || defined(_WIN32_DCOM)

	bool OpenNamedPipeClientToken(
		_In_ HANDLE hPipe,
		_In_ DWORD dwDesiredAccess,
		_In_ bool bImpersonate = false,
		_In_ bool bOpenAsSelf = true) throw(...);
	bool OpenRPCClientToken(
		_In_ RPC_BINDING_HANDLE BindingHandle,
		_In_ DWORD dwDesiredAccess,
		_In_ bool bImpersonate = false,
		_In_ bool bOpenAsSelf = true) throw(...);

	bool ImpersonateLoggedOnUser() const throw(...);
	bool Impersonate(_In_opt_ HANDLE hThread = NULL) const throw(...);
	bool Revert(_In_opt_ HANDLE hThread = NULL) const throw();

	bool LoadUserProfile() throw(...);
	HANDLE GetProfile() const throw();

	// Must hold Tcb privilege
	bool LogonUser(
		_In_z_ LPCTSTR pszUserName,
		_In_z_ LPCTSTR pszDomain,
		_In_z_ LPCTSTR pszPassword,
		_In_ DWORD dwLogonType = LOGON32_LOGON_INTERACTIVE,
		_In_ DWORD dwLogonProvider = LOGON32_PROVIDER_DEFAULT) throw();

	// Must hold AssignPrimaryToken (unless restricted token) and
	// IncreaseQuota privileges
	bool CreateProcessAsUser(
		_In_opt_z_ LPCTSTR pApplicationName,
		_In_opt_z_ LPTSTR pCommandLine,
		_In_ LPPROCESS_INFORMATION pProcessInformation,
		_In_ LPSTARTUPINFO pStartupInfo,
		_In_ DWORD dwCreationFlags = NORMAL_PRIORITY_CLASS,
		_In_ bool bLoadProfile = false,
		_In_opt_ const CSecurityAttributes *pProcessAttributes = NULL,
		_In_opt_ const CSecurityAttributes *pThreadAttributes = NULL,
		_In_ bool bInherit = false,
		_In_opt_z_ LPCTSTR pCurrentDirectory = NULL) throw();

protected:
	bool EnableDisablePrivileges(
		_In_ const CAtlArray<LPCTSTR> &rPrivileges,
		_In_ bool bEnable,
		_Inout_opt_ CTokenPrivileges *pPreviousState,
		_Out_opt_ bool* pbErrNotAllAssigned=NULL) throw(...);
	bool CheckImpersonation() const throw();

	bool RevertToLevel(_In_opt_ SECURITY_IMPERSONATION_LEVEL *pSil) const throw();

	virtual void Clear() throw();

	HANDLE m_hToken, m_hProfile;

private:
	CAccessToken(_In_ const CAccessToken &rhs) throw(...);
	CAccessToken &operator=(_In_ const CAccessToken &rhs) throw(...);

	class CRevert
	{
	public:
		virtual bool Revert() throw() = 0;
	};

	class CRevertToSelf : 
		public CRevert
	{
	public:
		bool Revert() throw()
		{
			return 0 != ::RevertToSelf();
		}
	};

#if (_WIN32_WINNT >= 0x0400 ) || defined(_WIN32_DCOM)
	class CCoRevertToSelf :
		public CRevert
	{
	public:
		bool Revert() throw()
		{
			return SUCCEEDED(::CoRevertToSelf());
		}
	};
#endif //(_WIN32_WINNT >= 0x0400 ) || defined(_WIN32_DCOM)

	class CRpcRevertToSelfEx : 
		public CRevert
	{
	public:
		CRpcRevertToSelfEx(_In_ RPC_BINDING_HANDLE BindingHandle) throw() :
			m_hBinding(BindingHandle)
		{
		}
		bool Revert() throw()
		{
			return RPC_S_OK == ::RpcRevertToSelfEx(m_hBinding);
		}

	private:
		RPC_BINDING_HANDLE m_hBinding;
	};
	mutable CRevert *m_pRevert;
};

//*******************************************
// CAutoRevertImpersonation

class CAutoRevertImpersonation
{
public:
	CAutoRevertImpersonation(_In_ const CAccessToken* pAT) throw();
	~CAutoRevertImpersonation() throw();

	void Attach(_In_ const CAccessToken* pAT) throw();
	const CAccessToken* Detach() throw();

	const CAccessToken* GetAccessToken() throw();

private:
	const CAccessToken* m_pAT;

	CAutoRevertImpersonation(_In_ const CAutoRevertImpersonation &rhs) throw(...);
	CAutoRevertImpersonation &operator=(_In_ const CAutoRevertImpersonation &rhs) throw(...);
};

//*******************************************
// CPrivateObjectSecurityDesc

class CPrivateObjectSecurityDesc : 
	public CSecurityDesc
{
public:
	CPrivateObjectSecurityDesc() throw();
	~CPrivateObjectSecurityDesc() throw();

	bool Create(
		_In_opt_ const CSecurityDesc *pParent,
		_In_opt_ const CSecurityDesc *pCreator,
		_In_ bool bIsDirectoryObject,
		_In_ const CAccessToken &Token,
		_In_ PGENERIC_MAPPING GenericMapping) throw();

#if(_WIN32_WINNT >= 0x0500)
	bool Create(
		_In_opt_ const CSecurityDesc *pParent,
		_In_opt_ const CSecurityDesc *pCreator,
		_In_opt_ GUID *ObjectType,
		_In_ bool bIsContainerObject,
		_In_ ULONG AutoInheritFlags,
		_In_ const CAccessToken &Token,
		_In_ PGENERIC_MAPPING GenericMapping) throw();
#endif

	bool Get(
		_In_ SECURITY_INFORMATION si,
		_Inout_ CSecurityDesc *pResult) const throw();
	bool Set(
		_In_ SECURITY_INFORMATION si,
		_In_ const CSecurityDesc &Modification,
		_In_ PGENERIC_MAPPING GenericMapping,
		_In_ const CAccessToken &Token) throw();

#if(_WIN32_WINNT >= 0x0500)
	bool Set(
		_In_ SECURITY_INFORMATION si,
		_In_ const CSecurityDesc &Modification,
		_In_ ULONG AutoInheritFlags,
		_In_ PGENERIC_MAPPING GenericMapping,
		_In_ const CAccessToken &Token) throw();

	bool ConvertToAutoInherit(
		_In_opt_ const CSecurityDesc *pParent,
		_In_opt_ GUID *ObjectType,
		_In_ bool bIsDirectoryObject,
		_In_ PGENERIC_MAPPING GenericMapping) throw();
#endif

protected:
	void Clear() throw();

private:
	bool m_bPrivate;

	CPrivateObjectSecurityDesc(_In_ const CPrivateObjectSecurityDesc &rhs) throw(...);
	CPrivateObjectSecurityDesc &operator=(_In_ const CPrivateObjectSecurityDesc &rhs) throw(...);
};

//*******************************************
// Global Functions

inline bool AtlGetSecurityDescriptor(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CSecurityDesc *pSecurityDescriptor,
	_In_ SECURITY_INFORMATION requestedInfo =
		OWNER_SECURITY_INFORMATION |
		GROUP_SECURITY_INFORMATION |
		DACL_SECURITY_INFORMATION |
		SACL_SECURITY_INFORMATION,
	_In_ bool bRequestNeededPrivileges = true) throw(...);

inline bool AtlGetSecurityDescriptor(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CSecurityDesc *pSecurityDescriptor,
	_In_ SECURITY_INFORMATION requestedInfo =
		OWNER_SECURITY_INFORMATION |
		GROUP_SECURITY_INFORMATION |
		DACL_SECURITY_INFORMATION |
		SACL_SECURITY_INFORMATION,
	_In_ bool bRequestNeededPrivileges = true) throw(...);

inline bool AtlGetOwnerSid(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CSid *pSid) throw(...);

inline bool AtlSetOwnerSid(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_In_ const CSid &rSid) throw(...);

inline bool AtlGetOwnerSid(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CSid *pSid) throw(...);

inline bool AtlSetOwnerSid(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_In_ const CSid &rSid) throw(...);

inline bool AtlGetGroupSid(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CSid *pSid) throw(...);

inline bool AtlSetGroupSid(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_In_ const CSid &rSid) throw(...);

inline bool AtlGetGroupSid(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CSid *pSid) throw(...);

inline bool AtlSetGroupSid(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_In_ const CSid &rSid) throw(...);

inline bool AtlGetDacl(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CDacl *pDacl) throw(...);

inline bool AtlSetDacl(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_In_ const CDacl &rDacl,
	_In_ DWORD dwInheritanceFlowControl = 0) throw(...);

inline bool AtlGetDacl(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CDacl *pDacl) throw(...);

inline bool AtlSetDacl(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_In_ const CDacl &rDacl,
	_In_ DWORD dwInheritanceFlowControl = 0) throw(...);

inline bool AtlGetSacl(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CSacl *pSacl,
	_In_ bool bRequestNeededPrivileges = true) throw(...);

inline bool AtlSetSacl(
	_In_ HANDLE hObject,
	_In_ SE_OBJECT_TYPE ObjectType,
	_In_ const CSacl &rSacl,
	_In_ DWORD dwInheritanceFlowControl = 0,
	_In_ bool bRequestNeededPrivileges = true) throw(...);

inline bool AtlGetSacl(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_Inout_ CSacl *pSacl,
	_In_ bool bRequestNeededPrivileges = true) throw(...);

inline bool AtlSetSacl(
	_In_z_ LPCTSTR pszObjectName,
	_In_ SE_OBJECT_TYPE ObjectType,
	_In_ const CSacl &rSacl,
	_In_ DWORD dwInheritanceFlowControl = 0,
	_In_ bool bRequestNeededPrivileges = true) throw(...);

} // namespace ATL


#pragma warning(pop)

#include <atlsecurity.inl>
#pragma pack(pop)
#endif // __ATLSECURITY_H__
